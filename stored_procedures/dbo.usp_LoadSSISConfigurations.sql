USE [SSIS_PDS]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 11/3/2019 11:11:00 PM ******/
DROP PROCEDURE [dbo].[usp_LoadSSISConfigurations]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 11/3/2019 11:11:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_LoadSSISConfigurations]
AS
    BEGIN

/*****************************************************************************************************************
NAME:    dbo.usp_LoadSSISConfigurations
PURPOSE: Load the SSIS Configurations table

MODIFICATION LOG:
Ver      Date        Author           Description
-------  ----------  ---------------  ------------------------------------------------------------------------
1.0      11/03/2019  JJAUSSI          1. Created this process for LDS BC IT243



RUNTIME: 
approx 5 sec

NOTES:  
Load configured variable values for these levels...
1) System
2) Solution
4) Package


Loads configuration managers for common configuration managers used in template package

Connect strings are loaded with passwords to allow for automation of SSIS ETL based packages
         
******************************************************************************************************************/



    -- 1) CommonConfigurations

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'CommonConfigurations';


    ---- 1.1) conn_DA

    --INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
    --                                    , ConfiguredValue
    --                                    , PackagePath
    --                                    , ConfiguredValueType)
    --VALUES
    --      (
    --       'CommonConfigurations'
    --     , 'Data Source=localhost;Initial Catalog=DA;Provider=SQLNCLI11;Integrated Security=SSPI;'
    --     , '\Package.Variables[User::conn_DA].Properties[Value]'
    --     , 'String'
    --      );


    -- 1.2) conn_EXM

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'CommonConfigurations'
         , 'Data Source=localhost;Initial Catalog=EXM;Provider=SQLNCLI11;Integrated Security=SSPI;'
         , '\Package.Variables[User::conn_EXM].Properties[Value]'
         , 'String'
          );





    -- 2) SSIS_PDS_Template

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'SSIS_PDS_Template';


    -- 2.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'SSIS_PDS_Template'
         --, 'C:\Users\z035330\Documents\JJAUSSI\Other\JC\dev_files\txt_files\'
		 , 'C:\Users\z035330\Documents\JJAUSSI\Other\JC\projects\LDSBC\IT_243\repos\SSIS_PDS\txt_files\'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );





    -- 3) LoadEXM

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'LoadEXM';


    -- 2.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'LoadEXM'
         --, 'C:\Users\z035330\Documents\JJAUSSI\Other\JC\dev_files\txt_files\'
		 , 'C:\Users\z035330\Documents\JJAUSSI\Other\JC\projects\LDSBC\IT_243\repos\EXM\txt_files\'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );

END;

GO


