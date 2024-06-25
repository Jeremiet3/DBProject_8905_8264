CREATE OR REPLACE PROCEDURE update_cleaning_supplies
IS
    CURSOR c_low_supplies IS
        SELECT SUID, Name, Total_Quantity, Location
        FROM Cleaning_Supply
        WHERE Total_Quantity < 10
        FOR UPDATE;

    v_restock_amount INT;
    v_total_restocked INT := 0;
    v_total_cost FLOAT := 0;
    e_restock_limit_reached EXCEPTION;
BEGIN
    FOR supply IN c_low_supplies LOOP
        v_restock_amount := FLOOR(DBMS_RANDOM.VALUE(20, 51)); -- Random restock between 20 and 50

        UPDATE Cleaning_Supply
        SET Total_Quantity = Total_Quantity + v_restock_amount
        WHERE CURRENT OF c_low_supplies;

        v_total_restocked := v_total_restocked + 1;
        v_total_cost := v_total_cost + (v_restock_amount * 2.5); -- Assuming $2.5 per unit

        DBMS_OUTPUT.PUT_LINE('Restocked ' || supply.Name || ' with ' || v_restock_amount || ' units in ' || supply.Location);

        IF v_total_restocked >= 5 THEN
            RAISE e_restock_limit_reached;
        END IF;
    END LOOP;

    IF v_total_restocked = 0 THEN
        DBMS_OUTPUT.PUT_LINE('All supplies are adequately stocked.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total items restocked: ' || v_total_restocked);
        DBMS_OUTPUT.PUT_LINE('Total restock cost: $' || ROUND(v_total_cost, 2));
    END IF;

    COMMIT;
EXCEPTION
    WHEN e_restock_limit_reached THEN
        DBMS_OUTPUT.PUT_LINE('Restock limit reached. Restocked ' || v_total_restocked || ' items.');
        DBMS_OUTPUT.PUT_LINE('Total restock cost: $' || ROUND(v_total_cost, 2));
        COMMIT;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in update_cleaning_supplies: ' || SQLERRM);
        ROLLBACK;
END update_cleaning_supplies;
/
