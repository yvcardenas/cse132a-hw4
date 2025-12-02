-- INSTRUCTIONS
-- TASK: Write a query to list each employee along with all managers above them, directly or indirectly.
-- 1. Use a recursive CTE named Hierarchy.
-- 2. The base case selects (ename, managerid) for employees with a manager.
-- 3. The recursive case joins to managers recursively using managerid
-- 4. Order the output by employee_name, manager_name.

WITH RECURSIVE Hierarchy(employee_name, manager_id) AS (
--     Run the base case once, feed it into the recursive case, repeat until no new rows are generated and return the entire result
--     Base Case
    SELECT ename, managerid
    FROM employee
    WHERE managerid IS NOT NULL

    UNION
--     Recursive Step
    SELECT h.employee_name, e.managerid
    FROM Hierarchy h JOIN employee e on h.manager_id = e.eid
    WHERE  e.managerid IS NOT NULL
)
SELECT h.employee_name, e.ename AS manager_name
FROM Hierarchy h JOIN employee e on h.manager_id = e.eid
ORDER BY h.employee_name, manager_name;