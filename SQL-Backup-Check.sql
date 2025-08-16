/*
SQL-Backup-Check.sql
Purpose: Verify last database backup status and highlight any failures
Author: Ashish (Support Engineer)
*/

-- Show last full, differential, and log backups for each database
SELECT
    d.name AS DatabaseName,
    COALESCE(MAX(CASE WHEN b.type = 'D' THEN b.backup_finish_date END), 'No Full Backup') AS LastFullBackup,
    COALESCE(MAX(CASE WHEN b.type = 'I' THEN b.backup_finish_date END), 'No Diff Backup') AS LastDifferentialBackup,
    COALESCE(MAX(CASE WHEN b.type = 'L' THEN b.backup_finish_date END), 'No Log Backup') AS LastLogBackup
FROM
    sys.databases d
LEFT JOIN
    msdb.dbo.backupset b
    ON b.database_name = d.name
GROUP BY
    d.name
ORDER BY
    d.name;

-- Check if any database hasn’t had a backup in the last 24 hours
SELECT
    d.name AS DatabaseName,
    MAX(b.backup_finish_date) AS LastBackup
FROM
    sys.databases d
LEFT JOIN
    msdb.dbo.backupset b
    ON b.database_name = d.name
GROUP BY
    d.name
HAVING
    MAX(b.backup_finish_date) < DATEADD(DAY, -1, GETDATE())
    OR MAX(b.backup_finish_date) IS NULL
ORDER BY
    LastBackup;
