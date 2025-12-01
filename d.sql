-- SCENARIO: Each topic can have subtopics (recursive hierarchy), and each discussion stores multiple messages as an array.
-- TASK: Write a query to find all descendant topics of 'Support' that have at least one message containing the word 'refund' or 'return' (case-insensitive)
-- INSTRUCTIONS:
-- 1. Create a recursive CTE Subtopics (tid, tname, parent_id) starting from the row where tname = 'Support'.
-- 2. Join Subtopics with Discussion to access message arrays.
-- 3. Use unnest(messages) to expand the array.
-- 4. Filter messages using regex:
--      WHERE msg ~*'(refund|return)'
-- 5. Return unique topic names and the matching message text
WITH RECURSIVE Subtopics(tid, tname, parent_tid) AS (
--     Base Case
    SELECT tid, tname, parent_tid
    FROM topic
    WHERE tname = 'Support'

    UNION ALL
--     Recursive Case
    SELECT t.tid, t.tname, t.parent_tid
    FROM Subtopics s JOIN topic t on t.parent_tid = s.tid
)
SELECT DISTINCT s.tname as tname, msg
FROM Subtopics s JOIN discussion d ON s.tid = d.tid
CROSS JOIN LATERAL unnest(messages) AS msg
WHERE msg ~*'(refund|return)';