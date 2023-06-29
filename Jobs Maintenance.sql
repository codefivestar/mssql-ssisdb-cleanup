--
-- SSIS Server Operation Records Maintenance
--
DECLARE @role INT

	SET @role = (
			     SELECT [role]
			       FROM [sys].[dm_hadr_availability_replica_states] hars
			 INNER JOIN [sys].[availability_databases_cluster] adc
				     ON hars.[group_id] = adc.[group_id]
			      WHERE hars.[is_local] = 1
				    AND adc.[database_name] = 'SSISDB'
			    )

IF DB_ID('SSISDB') IS NOT NULL AND (@role IS NULL OR @role = 1)
	EXEC [SSISDB].[internal].[cleanup_server_retention_window]
	
GO

--
-- SSIS Server Max Version Per Project Maintenance
--
DECLARE @role INT

	SET @role = (
			     SELECT [role]
			       FROM [sys].[dm_hadr_availability_replica_states] hars
			 INNER JOIN [sys].[availability_databases_cluster] adc
				     ON hars.[group_id] = adc.[group_id]
			      WHERE hars.[is_local] = 1
				    AND adc.[database_name] = 'SSISDB'
			    )

IF DB_ID('SSISDB') IS NOT NULL AND (@role IS NULL OR @role = 1)
	EXEC [SSISDB].[internal].[cleanup_server_project_version]
	
GO


