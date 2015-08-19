CREATE DATABASE UnifiedDatabase
GO
use UnifiedDatabase
GO
CREATE SCHEMA PROJECT 
GO
CREATE SCHEMA EMPLOYEE 
GO
CREATE SCHEMA COMMON 
GO
CREATE SCHEMA BENEFITS 
GO
CREATE SCHEMA CHANGE_LOG
GO

/***********************
**COMMON SCHEMA TABLES**
************************/	
CREATE TABLE COMMON.LookupCategory(	
	LookupCategory_Sk INT IDENTITY(1,1) PRIMARY KEY,
	LookupCategoryName VARCHAR(255),
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)	
CREATE TABLE COMMON.LookupElement(	
	LookupElement_Sk INT IDENTITY(1,1) PRIMARY KEY,
	LookupCategory_Sk INT,
	LookupElementName VARCHAR(255),
	LookupDescription VARCHAR(255),
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)	
CREATE TABLE COMMON.Configurables(	
	Configurables_Sk INT IDENTITY(1,1) PRIMARY KEY,
	ConfigKey VARCHAR(255),
	KeyValue VARCHAR(255),
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)
/*************************
**EMPLOYEE SCHEMA TABLES**
**************************/	
CREATE TABLE EMPLOYEE.Person(	
	Person_Sk INT IDENTITY(1,1) PRIMARY KEY,
	UserName VARCHAR(255),
	FirstName VARCHAR(255),
	MiddleName VARCHAR(255),
	LastName VARCHAR(255),
	IsAdmin BIT,
	IsActive BIT,
	HireDate DATE,
	EmployeeTypeLookup_Sk INT,
	YearsProfessionalPrior DECIMAL(10,2) DEFAULT 0,
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)

CREATE TABLE EMPLOYEE.PositionHistory(	
	PositionHistory_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Person_Sk INT,
	PositionLookup_Sk INT,
	EffectiveDate DATE,
	EndDate DATE,
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
) 

GO
CREATE VIEW EMPLOYEE.Position
AS	SELECT	p.FirstName + ' ' + p.LastName AS Name,
			le.LookupElementName AS Position
	FROM	EMPLOYEE.PositionHistory ph
				JOIN EMPLOYEE.Person p ON ph.Person_Sk = p.Person_Sk
				JOIN COMMON.LookupElement le ON ph.PositionLookup_Sk = le.LookupElement_Sk
GO

/************************
**PROJECT SCHEMA TABLES**
*************************/	
CREATE TABLE PROJECT.Client(	
	Client_Sk INT IDENTITY(1,1) PRIMARY KEY,
	ClientName VARCHAR(255),
	ClientTypeLookup_Sk INT,
	ClientStatusLookup_Sk INT,
	CreatedDate DATETIME2(2),
	CreatedPerson_Sk INT,
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
) 	
CREATE TABLE PROJECT.Project(	
	Project_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Client_Sk INT,
	ParentProject_Sk INT,
	ProjectName VARCHAR(255),
	ProjectStatusLookup_Sk INT,
	ProjectTypeLookup_Sk INT,
	IsBillable BIT,
	CreatedDate DATETIME2(2),
	CreatedPerson_Sk INT,
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)	
CREATE TABLE PROJECT.PersonToProject(	
	PersonToProject_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Person_Sk INT,
	Project_Sk INT,
	RoleLookup_Sk INT,
	IsProjectAdmin BIT,
	CreatedDate DATETIME2(2),
	CreatedPerson_Sk INT,
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)	
CREATE TABLE PROJECT.Task(	
	Task_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Project_Sk INT,
	TaskName VARCHAR(255),
	TaskDescription VARCHAR(255),
	TaskStatusLookup_Sk INT,
	TaskTypeLookup_Sk INT,
	IsOpen BIT,
	CreatedDate DATETIME2(2),
	CreatedPerson_Sk INT,
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)	
CREATE TABLE PROJECT.Activity(	
	Activity_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Task_Sk INT,
	Person_Sk INT,
	ActivityDate DATETIME2(2),
	ActivityDescription VARCHAR(1000),
	DurationTaken DECIMAL(10,2),
	IsBillable BIT,
	CreatedDate DATETIME2(2),
	LastModifiedDate DATETIME2(2),
)	

/*************************
**BENEFITS SCHEMA TABLES**
**************************/
CREATE TABLE BENEFITS.YearlyVacation(	
	YearlyVacation_Sk INT IDENTITY(1,1) PRIMARY KEY,
	CalendarYear DATE,
	BaseDays DECIMAL(10,2),
	EarnedDays DECIMAL(10,2),
	Person_Sk INT,
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)	
CREATE TABLE BENEFITS.PersonTimeOffTransaction(	
	PersonTimeOffTransaction_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Person_Sk INT,
	TransactionTypeLookup_Sk INT, --i.e. CANCEL, UPDATE, NEW
	TimeOffTypeLookup_Sk INT, --i.e. Personal, vacation, sick, etc
	StartDate DATETIME2(2),
	EndDate DATETIME2(2),
	NumDays DECIMAL(10,2),
	TransactionDate DATETIME2(2),
	Details VARCHAR(255),
	TimeOffCalendarEntry_Sk INT,
	ParentTransaction_Sk INT,
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)	
CREATE TABLE BENEFITS.AdminTimeOffTransaction(	
	AdminTimeOffTransaction_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Person_Sk INT,
	NumDays DECIMAL(10,2),
	SourceYear DATE,
	TargetYear DATE,
	TransactionTypeLookup_Sk INT, --i.e. Rollover, Yearly, points2vacationDays
	Details VARCHAR(255),
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)	

/*CREATE TABLE BENEFITS.TimeOffStatus(	
	TimeOffStatus_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Person_Sk INT,
	VacationDaysRemaining DECIMAL(18, 2),
	VacationDaysTaken DECIMAL(18, 2),
	SickDaysTaken DECIMAL(18, 2),
	PersonalDaysTaken DECIMAL(18, 2),
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
) */
	
GO
CREATE VIEW BENEFITS.TimeOffStatus
AS
SELECT	yv.Person_Sk,
		yv.BaseDays + yv.EarnedDays - SUM(ptot.NumDays /*WHERE ptot.TimeOffTypeLookup_Sk = numForVacation*/) AS VacationDaysRemaining,
		SUM(ptot.NumDays /* same as above */) AS VacationDaysTaken,
		SUM(ptot.NumDays /*WHERE TimeOffType is sick */) AS SickDaysTaken,
		SUM(ptot.NumDays /*WHERE TimeOffType is Personal*/) AS PersonalDaysTaken
FROM	BENEFITS.YearlyVacation yv
			JOIN BENEFITS.PersonTimeOffTransaction ptot ON yv.Person_Sk = ptot.Person_Sk
			JOIN BENEFITS.AdminTimeOffTransaction atot ON yv.Person_Sk = ptot.Person_Sk
WHERE	YEAR(yv.CalendarYear) = YEAR(GETDATE())
GROUP BY yv.Person_Sk, yv.BaseDays, yv.EarnedDays
GO

CREATE TABLE BENEFITS.TimeOffCalendarEntry(	
	TimeOffCalendarEntry_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Guid UNIQUEIDENTIFIER,
	CreatedDate DATETIME2(2), 
	CreatedPerson_Sk INT, 
	LastModifiedDate DATETIME2(2),
	LastModifiedPerson_Sk INT,
)		

/************** 	
**CHANGE LOGS**
***************/
----EMPLOYEE		
CREATE TABLE CHANGE_LOG.Person(		
	CL_Person_Sk INT PRIMARY KEY,	
	UserName_ORIG VARCHAR(255),
	UserName_NEW VARCHAR(255),	
	FirstName_ORIG VARCHAR(255),
	FirstName_NEW VARCHAR(255),	
	MiddleName_ORIG VARCHAR(255),
	MiddleName_NEW VARCHAR(255),	
	LastName_ORIG VARCHAR(255),
	LastName_NEW VARCHAR(255),	
	IsAdmin_ORIG BIT,
	IsAdmin_NEW BIT,	
	IsActive_ORIG BIT,
	IsActive_NEW BIT,	
	HireDate_ORIG DATE,
	HireDate_NEW DATE,	
	EmployeeTypeLookup_Sk_ORIG INT,
	EmployeeTypeLookup_Sk_NEW INT,	
	YearsProfessionalPrior_ORIG DECIMAL(10,2) DEFAULT 0,
	YearsProfessionalPrior_NEW DECIMAL(10,2) DEFAULT 0,	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)
CREATE TABLE CHANGE_LOG.PositionHistory(		
	CL_PositionHistory_Sk INT IDENTITY(1,1) PRIMARY KEY,
	Person_Sk_ORIG INT,
	Person_Sk_NEW INT,	
	PositionLookup_Sk_ORIG INT,
	PositionLookup_Sk_NEW INT,	
	EffectiveDate_ORIG DATE,
	EffectiveDate_NEW DATE,	
	EndDate_ORIG DATE,
	EndDate_NEW DATE,	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)	

----COMMON		
CREATE TABLE CHANGE_LOG.LookupCategory(		
	CL_LookupCategory_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	LookupCategoryName_ORIG VARCHAR(255),
	LookupCategoryName_NEW VARCHAR(255),	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		
CREATE TABLE CHANGE_LOG.LookupElement(		
	CL_LookupElement_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	LookupCategory_Sk_ORIG INT,
	LookupCategory_Sk_NEW INT,	
	LookupElementName_ORIG VARCHAR(255),
	LookupElementName_NEW VARCHAR(255),	
	LookupDescription_ORIG VARCHAR(255),
	LookupDescription_NEW VARCHAR(255),	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		
----PROJECT		
CREATE TABLE CHANGE_LOG.Client(		
	CL_Client_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	ClientName_ORIG VARCHAR(255),
	ClientName_NEW VARCHAR(255),	
	ClientTypeLookup_Sk_ORIG INT,
	ClientTypeLookup_Sk_NEW INT,	
	ClientStatusLookup_Sk_ORIG INT,
	ClientStatusLookup_Sk_NEW INT,	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
) 		
CREATE TABLE CHANGE_LOG.Project(		
	CL_Project_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	Client_Sk_ORIG INT,
	Client_Sk_NEW INT,	
	ParentProject_Sk_ORIG INT,
	ParentProject_Sk_NEW INT,	
	ProjectName_ORIG VARCHAR(255),
	ProjectName_NEW VARCHAR(255),	
	ProjectStatusLookup_Sk_ORIG INT,
	ProjectStatusLookup_Sk_NEW INT,	
	ProjectTypeLookup_Sk_ORIG INT,
	ProjectTypeLookup_Sk_NEW INT,	
	IsBillable_ORIG BIT,
	IsBillable_NEW BIT,	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		
CREATE TABLE CHANGE_LOG.PersonToProject(		
	CL_PersonToProject_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	Person_Sk_ORIG INT,
	Person_Sk_NEW INT,	
	Project_Sk_ORIG INT,
	Project_Sk_NEW INT,	
	RoleLookup_Sk_ORIG INT,
	RoleLookup_Sk_NEW INT,
	IsProjectAdmin_ORIG BIT,
	IsProjectAdmin_NEW BIT,
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		
CREATE TABLE CHANGE_LOG.Task(		
	CL_Task_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	Project_Sk_ORIG INT,
	Project_Sk_NEW INT,	
	TaskName_ORIG VARCHAR(255),
	TaskName_NEW VARCHAR(255),	
	TaskDescription_ORIG VARCHAR(255),
	TaskDescription_NEW VARCHAR(255),	
	TaskStatusLookup_Sk_ORIG INT,
	TaskStatusLookup_Sk_NEW INT,	
	TaskTypeLookup_Sk_ORIG INT,
	TaskTypeLookup_Sk_NEW INT,	
	IsOpen_ORIG BIT,
	IsOpen_NEW BIT,	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		
CREATE TABLE CHANGE_LOG.Activity(		
	CL_Activity_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	Task_Sk_ORIG INT,
	Task_Sk_NEW INT,	
	Person_Sk_ORIG INT,
	Person_Sk_NEW INT,	
	ActivityDate_ORIG DATETIME2(2),
	ActivityDate_NEW DATETIME2(2),	
	ActivityDescription_ORIG VARCHAR(1000),
	ActivityDescription_NEW VARCHAR(1000),	
	DurationTaken_ORIG DECIMAL(10,2),
	DurationTaken_NEW DECIMAL(10,2),	
	IsBillable_ORIG BIT,IsBillable_NEW BIT,	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		
----BENEFITS		
/*CREATE TABLE CHANGE_LOG.TimeOffStatus(		
	CL_TimeOffStatus_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	Person_Sk_ORIG INT,
	Person_Sk_NEW INT,	
	VacationDaysRemaining_ORIG DECIMAL(18, 2),
	VacationDaysRemaining_NEW DECIMAL(18, 2), 	
	VacationDaysTaken_ORIG DECIMAL(18, 2),
	VacationDaysTaken_NEW DECIMAL(18, 2),	
	SickDaysTaken_ORIG DECIMAL(18, 2),
	SickDaysTaken_NEW DECIMAL(18, 2),	
	PersonalDaysTaken_ORIG DECIMAL(18, 2),
	PersonalDaysTaken_NEW DECIMAL(18, 2),	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		*/
CREATE TABLE CHANGE_LOG.YearlyVacation(		
	CL_YearlyVacation_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	CalendarYear_ORIG DATE,
	CalendarYear_NEW DATE,	
	BaseDays_ORIG DECIMAL(10,2),
	BaseDays_NEW DECIMAL(10,2),	
	EarnedDays_ORIG INT,
	EarnedDays_NEW INT,	
	Person_Sk_ORIG INT,
	Person_Sk_NEW INT,	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		
CREATE TABLE CHANGE_LOG.PersonTimeOffTransaction(		
	CL_PersonTimeOffTransaction_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	Person_Sk_ORIG INT,
	Person_Sk_NEW INT,
	TransactionTypeLookup_Sk_ORIG INT,
	TransactionTypeLookup_Sk_NEW INT,	
	TimeOffTypeLookup_Sk_ORIG INT,
	TimeOffTypeLookup_Sk_NEW INT, 	
	StartDate_ORIG DATETIME2(2),
	StartDate_NEW DATETIME2(2),	
	EndDate_ORIG DATETIME2(2),
	EndDate_NEW DATETIME2(2),	
	NumDays_ORIG DECIMAL(10,2),
	NumDays_NEW DECIMAL(10,2),	
	TransactionDate_ORIG DATETIME2(2),
	TransactionDate_NEW DATETIME2(2),	
	Details_ORIG VARCHAR(255),
	Details_NEW VARCHAR(255),	
	TimeOffCalendarEntry_Sk_ORIG INT,
	TimeOffCalendarEntry_Sk_NEW INT,	
	ParentTransaction_Sk_ORIG INT,
	ParentTransaction_Sk_NEW INT,
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)
CREATE TABLE CHANGE_LOG.AdminTimeOffTransaction(		
	CL_AdminTimeOffTransaction_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	Person_Sk_ORIG INT,
	Person_Sk_NEW INT,	
	NumDays_ORIG DECIMAL(10,2),
	NumDays_NEW DECIMAL(10,2),	
	SourceYear_ORIG DATE,
	SourceYear_NEW DATE,	
	TargetYear_ORIG DATE,
	TargetYear_NEW DATE,	
	TransactionTypeLookup_Sk_ORIG INT,
	TransactionTypeLookup_Sk_NEW INT,	
	Details_ORIG VARCHAR(255),
	Details_NEW VARCHAR(255),
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		
CREATE TABLE CHANGE_LOG.TimeOffCalendarEntry(		
	CL_TimeOffCalendarEntry_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	Guid_ORIG UNIQUEIDENTIFIER,
	Guid_NEW UNIQUEIDENTIFIER,	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		
CREATE TABLE CHANGE_LOG.Configurables(		
	CL_Configurables_Sk INT IDENTITY(1,1) PRIMARY KEY,	
	ConfigKey_ORIG VARCHAR(255),
	ConfigKey_NEW VARCHAR(255),	
	KeyValue_ORIG VARCHAR(255),
	KeyValue_NEW VARCHAR(255),	
	ModifyingPerson_Sk INT,
	ModifyingDate DATETIME2(2),
)		

/***************	
**FOREIGN KEYS**	
****************/	
--EMPLOYEE KEYS	
ALTER TABLE EMPLOYEE.Person	
ADD	CONSTRAINT FK_Person_LookupElement_Sk_EmployeeTypeLookup_Sk 
		FOREIGN KEY (EmployeeTypeLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Person_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_Person_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE EMPLOYEE.PositionHistory	
ADD	CONSTRAINT FK_PositionHistory_LookupElement_Sk_PositionLookup_Sk 
		FOREIGN KEY (PositionLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PositionHistory_Person_Sk_Person_Sk
		FOREIGN KEY (Person_Sk)
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PositionHistory_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PositionHistory_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk) 
		
--COMMON KEYS	
ALTER TABLE COMMON.LookupCategory	
ADD	CONSTRAINT FK_LookupCategory_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_LookupCategory_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE COMMON.LookupElement	
ADD	CONSTRAINT FK_LookupElement_LookupElement_Sk_LookupCategory_Sk 
		FOREIGN KEY (LookupCategory_Sk) 
		REFERENCES COMMON.LookupCategory(LookupCategory_Sk),
	CONSTRAINT FK_LookupElement_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_LookupElement_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
		
ALTER TABLE COMMON.Configurables	
ADD	CONSTRAINT FK_Configurables_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_Configurables_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)

--PROJECT KEYS	
ALTER TABLE PROJECT.Client	
ADD	CONSTRAINT FK_Client_LookupElement_Sk_ClientTypeLookup_Sk 
		FOREIGN KEY (ClientTypeLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Client_LookupElement_Sk_ClientStatusLookup_Sk 
		FOREIGN KEY (ClientStatusLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Client_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_Client_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE PROJECT.Project	
ADD	CONSTRAINT FK_Project_Client_Sk_Client_Sk 
		FOREIGN KEY (Client_Sk) 
		REFERENCES PROJECT.Client(Client_Sk),
	CONSTRAINT FK_Project_ParentProject_Sk_ParentProject_Sk 
		FOREIGN KEY (ParentProject_Sk) 
		REFERENCES PROJECT.Project(Project_Sk),
	CONSTRAINT FK_Project_LookupElement_Sk_ProjectStatusLookup_Sk 
		FOREIGN KEY (ProjectStatusLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Project_LookupElement_Sk_ProjectTypeLookup_Sk 
		FOREIGN KEY (ProjectTypeLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Project_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_Project_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE PROJECT.PersonToProject	
ADD	CONSTRAINT FK_PersonToProject_Person_Sk_Person_Sk 
		FOREIGN KEY (Person_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonToProject_Project_Sk_Project_Sk 
		FOREIGN KEY (Project_Sk) 
		REFERENCES PROJECT.Project(Project_Sk),
	CONSTRAINT FK_PersonToProject_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonToProject_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonToProject_LookupElement_Sk_RoleLookup_Sk 
		FOREIGN KEY (RoleLookup_Sk)
		REFERENCES COMMON.LookupElement(LookupElement_Sk)
	
ALTER TABLE PROJECT.Task	
ADD	CONSTRAINT FK_Task_Project_Sk_Project_Sk 
		FOREIGN KEY (Project_Sk) 
		REFERENCES PROJECT.Project(Project_Sk),
	CONSTRAINT FK_Task_LookupElement_Sk_TaskStatusLookup_Sk 
		FOREIGN KEY (TaskStatusLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Task_LookupElement_Sk_TaskTypeLookup_Sk 
		FOREIGN KEY (TaskTypeLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Task_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_Task_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE PROJECT.Activity	
ADD	CONSTRAINT FK_Activity_Task_Sk_Task_Sk 
		FOREIGN KEY (Task_Sk) 
		REFERENCES PROJECT.Task(Task_Sk),
	CONSTRAINT FK_Activity_Person_Sk_Person_Sk 
		FOREIGN KEY (Person_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
--BENEFITS KEYS	
/*ALTER TABLE BENEFITS.TimeOffStatus	
ADD	CONSTRAINT FK_TimeOffStatus_Person_Sk_Person_Sk 
		FOREIGN KEY (Person_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_TimeOffStatus_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_TimeOffStatus_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk) */
	
ALTER TABLE BENEFITS.YearlyVacation	
ADD	CONSTRAINT FK_YearlyVacation_Person_Sk_Person_Sk 
		FOREIGN KEY (Person_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_YearlyVacation_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_YearlyVacation_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE BENEFITS.PersonTimeOffTransaction	
ADD	CONSTRAINT FK_PersonTimeOffTransaction_Person_Sk_Person_Sk 
		FOREIGN KEY (Person_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_LookupElement_Sk_TimeOffTypeLookup_Sk 
		FOREIGN KEY (TimeOffTypeLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_TimeOffCalendarEntry_Sk_TimeOffCalendarEntry_Sk 
		FOREIGN KEY (TimeOffCalendarEntry_Sk) 
		REFERENCES BENEFITS.TimeOffCalendarEntry(TimeOffCalendarEntry_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_LookupElement_Sk_TransactionTypeLookup_Sk
		FOREIGN KEY (TransactionTypeLookup_Sk)
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_PersonTimeOffTransaction_Sk_ParentTransaction_Sk
		FOREIGN KEY (ParentTransaction_Sk)
		REFERENCES BENEFITS.PersonTimeOffTransaction(PersonTimeOffTransaction_Sk)
	
ALTER TABLE BENEFITS.AdminTimeOffTransaction	
ADD	CONSTRAINT FK_AdminTimeOffTransaction_Person_Sk_Person_Sk 
		FOREIGN KEY (Person_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_AdminTimeOffTransaction_LookupElement_Sk_TransactionTypeLookup_Sk 
		FOREIGN KEY (TransactionTypeLookup_Sk) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_AdminTimeOffTransaction_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_AdminTimeOffTransaction_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE BENEFITS.TimeOffCalendarEntry	
ADD	CONSTRAINT FK_TimeOffCalendarEntry_Person_Sk_CreatedPerson_Sk 
		FOREIGN KEY (CreatedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_TimeOffCalendarEntry_Person_Sk_LastModifiedPerson_Sk 
		FOREIGN KEY (LastModifiedPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
--CHANGE LOG KEYS	
----EMPLOYEE	
ALTER TABLE CHANGE_LOG.Person	
ADD	CONSTRAINT FK_Person_LookupElement_Sk_EmployeeTypeLookup_Sk_ORIG 
		FOREIGN KEY (EmployeeTypeLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Person_LookupElement_Sk_EmployeeTypeLookup_Sk_NEW 
		FOREIGN KEY (EmployeeTypeLookup_Sk_NEW) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Person_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE CHANGE_LOG.PositionHistory	
ADD	CONSTRAINT FK_PositionHistory_LookupElement_Sk_PositionLookup_Sk_ORIG 
		FOREIGN KEY (PositionLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PositionHistory_Person_Sk_Person_Sk_ORIG
		FOREIGN KEY (Person_Sk_ORIG)
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PositionHistory_Person_Sk_Person_Sk_NEW
		FOREIGN KEY (Person_Sk_NEW)
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PositionHistory_LookupElement_Sk_PositionLookup_Sk_NEW 
		FOREIGN KEY (PositionLookup_Sk_NEW) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PositionHistory_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk) 

----COMMON	
ALTER TABLE CHANGE_LOG.LookupCategory	
ADD	CONSTRAINT FK_LookupCategory_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE CHANGE_LOG.LookupElement	
ADD	CONSTRAINT FK_LookupElement_LookupElement_Sk_LookupCategory_Sk_ORIG 
		FOREIGN KEY (LookupCategory_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_LookupElement_LookupElement_Sk_LookupCategory_Sk_NEW 
		FOREIGN KEY (LookupCategory_Sk_NEW) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_LookupElement_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
----PROJECT	
ALTER TABLE CHANGE_LOG.Client	
ADD	CONSTRAINT FK_Client_LookupElement_Sk_ClientTypeLookup_Sk_ORIG 
		FOREIGN KEY (ClientTypeLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Client_LookupElement_Sk_ClientTypeLookup_Sk_NEW 
		FOREIGN KEY (ClientTypeLookup_Sk_NEW) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Client_LookupElement_Sk_ClientStatusLookup_Sk_ORIG 
		FOREIGN KEY (ClientStatusLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Client_LookupElement_Sk_ClientStatusLookup_Sk_NEW 
		FOREIGN KEY (ClientStatusLookup_Sk_NEW) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Client_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE CHANGE_LOG.Project	
ADD	CONSTRAINT FK_Project_Client_Sk_Client_Sk_ORIG 
		FOREIGN KEY (Client_Sk_ORIG) 
		REFERENCES PROJECT.Client(Client_Sk),
	CONSTRAINT FK_Project_Client_Sk_Client_Sk_NEW 
		FOREIGN KEY (Client_Sk_NEW) 
		REFERENCES PROJECT.Client(Client_Sk),
	CONSTRAINT FK_Project_Project_Sk_ParentProject_Sk_ORIG 
		FOREIGN KEY (ParentProject_Sk_ORIG) 
		REFERENCES PROJECT.Project(Project_Sk),
	CONSTRAINT FK_Project_Project_Sk_ParentProject_Sk_NEW 
		FOREIGN KEY (ParentProject_Sk_NEW) 
		REFERENCES PROJECT.Project(Project_Sk),
	CONSTRAINT FK_Project_LookupElement_Sk_ProjectStatusLookup_Sk_ORIG 
		FOREIGN KEY (ProjectStatusLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Project_LookupElement_Sk_ProjectStatusLookup_Sk_NEW 
		FOREIGN KEY (ProjectStatusLookup_Sk_NEW) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Project_LookupElement_Sk_ProjectTypeLookup_Sk_ORIG 
		FOREIGN KEY (ProjectTypeLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Project_LookupElement_Sk_ProjectTypeLookup_Sk_NEW 
		FOREIGN KEY (ProjectTypeLookup_Sk_NEW) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Project_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE CHANGE_LOG.PersonToProject	
ADD	CONSTRAINT FK_PersonToProject_Person_Sk_Person_Sk_ORIG 
		FOREIGN KEY (Person_Sk_ORIG) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonToProject_Person_Sk_Person_Sk_NEW 
		FOREIGN KEY (Person_Sk_NEW) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonToProject_Project_Sk_Project_Sk_ORIG 
		FOREIGN KEY (Project_Sk_ORIG) 
		REFERENCES PROJECT.Project(Project_Sk),
	CONSTRAINT FK_PersonToProject_Project_Sk_Project_Sk_NEW 
		FOREIGN KEY (Project_Sk_NEW) 
		REFERENCES PROJECT.Project(Project_Sk),
	CONSTRAINT FK_PersonToProject_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonToProject_LookupElement_Sk_RoleLookup_Sk_ORIG
		FOREIGN KEY (RoleLookup_Sk_ORIG)
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PersonToProject_LookupElement_Sk_RoleLookup_Sk_NEW
		FOREIGN KEY (RoleLookup_Sk_NEW)
		REFERENCES COMMON.LookupElement(LookupElement_Sk)
	
ALTER TABLE CHANGE_LOG.Task	
ADD	CONSTRAINT FK_Task_Project_Sk_Project_Sk_ORIG 
		FOREIGN KEY (Project_Sk_ORIG)
		REFERENCES PROJECT.Project(Project_Sk),
	CONSTRAINT FK_Task_Project_Sk_Project_Sk_NEW 
		FOREIGN KEY (Project_Sk_NEW) 
		REFERENCES PROJECT.Project(Project_Sk),
	CONSTRAINT FK_Task_LookupElement_Sk_TaskStatusLookup_Sk_ORIG 
		FOREIGN KEY (TaskStatusLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Task_LookupElement_Sk_TaskStatusLookup_Sk_NEW 
		FOREIGN KEY (TaskStatusLookup_Sk_NEW)
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Task_LookupElement_Sk_TaskTypeLookup_Sk_ORIG 
		FOREIGN KEY (TaskTypeLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Task_LookupElement_Sk_TaskTypeLookup_Sk_NEW 
		FOREIGN KEY (TaskTypeLookup_Sk_NEW) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_Task_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE CHANGE_LOG.Activity	
ADD	CONSTRAINT FK_Activity_Task_Sk_Task_Sk_ORIG 
		FOREIGN KEY (Task_Sk_ORIG) 
		REFERENCES PROJECT.Task(Task_Sk),
	CONSTRAINT FK_Activity_Task_Sk_Task_Sk_NEW 
		FOREIGN KEY (Task_Sk_NEW) 
		REFERENCES PROJECT.Task(Task_Sk),
	CONSTRAINT FK_Activity_Person_Sk_Person_Sk_ORIG 
		FOREIGN KEY (Person_Sk_ORIG) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_Activity_Person_Sk_Person_Sk_NEW 
		FOREIGN KEY (Person_Sk_NEW) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_Activity_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
----BENEFITS	
/*ALTER TABLE CHANGE_LOG.TimeOffStatus	
ADD	CONSTRAINT FK_TimeOffStatus_Person_Sk_Person_Sk_ORIG 
		FOREIGN KEY (Person_Sk_ORIG) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_TimeOffStatus_Person_Sk_Person_Sk_NEW 
		FOREIGN KEY (Person_Sk_NEW) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_TimeOffStatus_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk) */
	
ALTER TABLE CHANGE_LOG.YearlyVacation	
ADD	CONSTRAINT FK_YearlyVacation_Person_Sk_Person_Sk_ORIG 
		FOREIGN KEY (Person_Sk_ORIG) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_YearlyVacation_Person_Sk_Person_Sk_NEW 
		FOREIGN KEY (Person_Sk_NEW) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_YearlyVacation_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE CHANGE_LOG.PersonTimeOffTransaction	
ADD	CONSTRAINT FK_PersonTimeOffTransaction_Person_Sk_Person_Sk_ORIG 
		FOREIGN KEY (Person_Sk_ORIG) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_Person_Sk_Person_Sk_NEW 
		FOREIGN KEY (Person_Sk_NEW) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_LookupElement_Sk_TimeOffTypeLookup_Sk_ORIG 
		FOREIGN KEY (TimeOffTypeLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_LookupElement_Sk_TimeOffTypeLookup_Sk_NEW 
		FOREIGN KEY (TimeOffTypeLookup_Sk_NEW) 
		REFERENCES  COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_TimeOffCalendarEntry_Sk_TimeOffCalendarEntry_Sk_ORIG 
		FOREIGN KEY (TimeOffCalendarEntry_Sk_ORIG) 
		REFERENCES BENEFITS.TimeOffCalendarEntry(TimeOffCalendarEntry_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_TimeOffCalendarEntry_Sk_TimeOffCalendarEntry_Sk_NEW 
		FOREIGN KEY (TimeOffCalendarEntry_Sk_NEW) 
		REFERENCES BENEFITS.TimeOffCalendarEntry(TimeOffCalendarEntry_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_LookupElement_Sk_TransactionTypeLookup_Sk_ORIG
		FOREIGN KEY (TransactionTypeLookup_Sk_ORIG)
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_PersonTimeOffTransaction_Sk_ParentTransaction_Sk_ORIG
		FOREIGN KEY (ParentTransaction_Sk_ORIG)
		REFERENCES BENEFITS.PersonTimeOffTransaction(PersonTimeOffTransaction_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_LookupElement_Sk_TransactionTypeLookup_Sk_NEW
		FOREIGN KEY (TransactionTypeLookup_Sk_NEW)
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_PersonTimeOffTransaction_PersonTimeOffTransaction_Sk_ParentTransaction_Sk_NEW
		FOREIGN KEY (ParentTransaction_Sk_NEW)
		REFERENCES BENEFITS.PersonTimeOffTransaction(PersonTimeOffTransaction_Sk)
	
ALTER TABLE CHANGE_LOG.AdminTimeOffTransaction	
ADD	CONSTRAINT FK_AdminTimeOffTransaction_Person_Sk_Person_Sk_ORIG 
		FOREIGN KEY (Person_Sk_ORIG) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_AdminTimeOffTransaction_Person_Sk_Person_Sk_NEW 
		FOREIGN KEY (Person_Sk_NEW) 
		REFERENCES EMPLOYEE.Person(Person_Sk),
	CONSTRAINT FK_AdminTimeOffTransaction_LookupElement_Sk_TransactionTypeLookup_Sk_ORIG 
		FOREIGN KEY (TransactionTypeLookup_Sk_ORIG) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_AdminTimeOffTransaction_LookupElement_Sk_TransactionTypeLookup_Sk_NEW 
		FOREIGN KEY (TransactionTypeLookup_Sk_NEW) 
		REFERENCES COMMON.LookupElement(LookupElement_Sk),
	CONSTRAINT FK_AdminTimeOffTransaction_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)
	
ALTER TABLE CHANGE_LOG.TimeOffCalendarEntry	
ADD	CONSTRAINT FK_TimeOffCalendarEntry_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)

ALTER TABLE CHANGE_LOG.Configurables	
ADD	CONSTRAINT FK_Configurables_Person_Sk_ModifyingPerson_Sk 
		FOREIGN KEY (ModifyingPerson_Sk) 
		REFERENCES EMPLOYEE.Person(Person_Sk)

/**************************
**BACKWARDS COMPATIBILITY**
***************************/

--LOOK INTO TYPE MATCHING 
/*New model uses DateTime2(2), old model is DateTime 
	CAST needed?
  VARCHAR(smaller) -> VARCHAR(larger) problem?
  Can new model uses NVARCHAR? 
                                                    */


GO

CREATE VIEW AccessControl
AS	
SELECT	p.PersonToProject_Sk AS AccessControlID,
		p.Project_Sk AS ProjectID,
		p.RoleLookup_Sk AS RoleID,
		p.Person_Sk AS UserID
FROM	PROJECT.PersonToProject p
GO

CREATE VIEW Activity
AS	
SELECT	a.Activity_Sk AS ActivityID,
		a.Task_Sk AS TaskID,
		a.Person_Sk AS UserID,
		a.ActivityDate, 
		NULL AS ActivityType_Lookup, /*Is this stored somewhere else/needed as not null? */
		CAST(a.ActivityDescription AS TEXT) AS ActivityDescription,
		a.Person_Sk AS CreatedModifiedUserID,
		ISNULL(a.LastModifiedDate, a.CreatedDate) AS CreatedModifiedDateTime,
		a.DurationTaken AS DurationTaken,
		a.IsBillable
FROM	PROJECT.Activity a
GO

CREATE VIEW ActivityBackup
AS	
SELECT	a.Activity_Sk AS ActivityID,
		a.Task_Sk AS TaskID,
		a.Person_Sk AS UserID,
		a.ActivityDate, 
		NULL AS ActivityType_Lookup, /*Is this stored somewhere else/needed as not null? */
		CAST(a.ActivityDescription AS TEXT) AS ActivityDescription,
		a.Person_Sk AS CreatedModifiedUserID,
		ISNULL(a.LastModifiedDate, a.CreatedDate) AS CreatedModifiedDateTime,
		a.DurationTaken AS DurationTaken,
		a.IsBillable
FROM	PROJECT.Activity a
GO

CREATE TABLE Attachment(
	AttachmentID INT PRIMARY KEY,
	AttachmentName VARCHAR(200),
	AttachmentBody TEXT,
	ParentID INT,
	ParentType_Lookup INT,
	AttachmentType_Lookup INT,
	CreatedModifiedDateTime datetime NOT NULL,
	CreatedModifiedUserID INT NOT NULL
)
GO

CREATE VIEW Client
AS	
SELECT	c.Client_Sk AS ClientID,
		c.ClientName, 
		c.ClientTypeLookup_Sk AS ClientType_Lookup,
		c.ClientStatusLookup_Sk AS ClientStatus_Lookup,
		ISNULL(c.LastModifiedDate, c.CreatedDate) AS CreatedModifiedDateTime,
		ISNULL(c.LastModifiedPerson_Sk, c.CreatedPerson_Sk) AS CreatedModifiedUserID
FROM	PROJECT.Client c
GO

CREATE VIEW Contact
AS	
SELECT	p.Person_Sk AS ContactID,
		NULL AS ClientID, /* I believe this is unused because Contact is unused, buuuuut */
		p.FirstName,
		p.LastName,
		NULL AS Email,
		NULL AS PhoneNumber,
		NULL AS FaxNumber,
		NULL AS CellPhone
FROM	EMPLOYEE.Person p
GO

CREATE VIEW LegacyProjects
AS	
SELECT	p.Project_Sk AS Projectid,
		c.ClientName AS Name,
		c.Client_Sk AS Clientid,
		l.LookupElementName AS Status
FROM	PROJECT.Project p
			JOIN PROJECT.Client c ON c.Client_Sk = p.Client_Sk
			JOIN COMMON.LookupElement l ON l.LookupElement_Sk = p.ProjectStatusLookup_Sk
GO

CREATE VIEW LegacyTimeTracking
AS	
SELECT	ROW_NUMBER() OVER(ORDER BY p.Project_Sk) AS Recordid, --REALLY needs looking over
		per.UserName AS Userid,
		p.Project_Sk AS Projectid,
		a.ActivityDate AS [Date],
		a.DurationTaken AS Duration,
		a.ActivityDescription AS [Description]
FROM	PROJECT.Activity a
			JOIN PROJECT.Task t ON a.Task_Sk = t.Task_Sk
			JOIN PROJECT.Project p ON p.Project_Sk = t.Project_Sk
			JOIN EMPLOYEE.Person per ON per.Person_Sk = a.Person_Sk
GO

CREATE VIEW LookupCategory
AS	
SELECT	l.LookupCategory_Sk AS LookupCategoryID,
		l.LookupCategoryName
FROM	COMMON.LookupCategory l
GO

CREATE VIEW LookupElement
AS	
SELECT	l.LookupElement_Sk AS LookupElementID,
		l.LookupElementName,
		l.LookupCategory_Sk AS LookupCategoryID,
		(ROW_NUMBER() OVER (PARTITION BY LookupCategory_Sk ORDER BY LookupElement_Sk ASC)) * 10 AS LookupSequence
FROM	COMMON.LookupElement l
GO

CREATE TABLE Note(
	NoteID INT PRIMARY KEY,
	NoteDescription text,
	ParentID INT NOT NULL,
	ParentType_Lookup INT NOT NULL,
	CreatedModifiedDateTime DATETIME NOT NULL,
	CreatedModifiedUserID INT NOT NULL
)
GO

CREATE TABLE Notification_vw(
	NotificationTypeId VARCHAR(MAX),
	ClientID VARCHAR(MAX),
	ProjectID VARCHAR(MAX),
	TaskID VARCHAR(MAX),
	UserID VARCHAR(MAX)
)
GO

CREATE VIEW Project
AS	
SELECT	p.Project_Sk AS ProjectID,
		p.Client_Sk AS ClientID,
		p.ParentProject_Sk AS ParentProjectID,
		p.ProjectName,
		p.ProjectStatusLookup_Sk AS ProjectStatus_Lookup,
		p.ProjectTypeLookup_Sk AS ProjectType_Lookup,
		NULL AS EstimateCompletionDate,
		NULL AS EstimateDuration,
		ISNULL(p.LastModifiedDate, p.CreatedDate) AS CreatedModifiedDateTime,
		ISNULL(p.LastModifiedPerson_Sk, p.CreatedPerson_Sk) AS CreatedModifiedUserID,
		p.IsBillable
FROM	PROJECT.Project p
GO

CREATE VIEW Role 
AS	
SELECT	l.LookupElement_Sk AS RoleID,
		l.LookupElementName AS RoleName 
FROM	COMMON.LookupElement l
			JOIN COMMON.LookupCategory lc ON lc.LookupCategory_Sk = l.LookupCategory_Sk
WHERE	lc.LookupCategoryName = 'Role'
GO

CREATE TABLE Sessions(
	id VARCHAR(100) PRIMARY KEY,
	valid CHAR(1) NOT NULL,
	maxinactive INT NOT NULL,
	lastaccess BIGINT,
	context VARCHAR(200),
	data IMAGE NOT NULL
)
GO

CREATE VIEW Task
AS	
SELECT	t.Task_Sk AS TaskID,
		t.Project_Sk AS ProjectID,
		t.TaskName,
		t.TaskTypeLookup_Sk AS TaskTypeID,
		t.TaskStatusLookup_Sk AS TaskStatusId,
		CAST(t.TaskDescription AS TEXT) AS TaskDescription,
		NULL AS CurrentUserID, /*Check if these values need come from somewher else */
		NULL AS AssignedToUserID,
		NULL AS AssignedToRoleID,
		NULL AS EstimateDuration,
		NULL AS EstimateCompletionDate,
		t.CreatedDate,
		t.CreatedPerson_Sk AS CreatedUserID,
		ISNULL(t.LastModifiedDate, t.CreatedDate) AS CreatedModifiedDateTime,
		ISNULL(t.LastModifiedPerson_Sk, t.CreatedPerson_Sk) AS CreatedModifiedUserID
FROM	PROJECT.Task t
GO

CREATE TABLE [Task Tracking Client](
	ClientID FLOAT,
	Created_Modified_DateTime SMALLDATETIME,
	Created_Modified_UserID FLOAT,
	ClientName NVARCHAR(255),
	ClientType_Lookup FLOAT,
	F6 NVARCHAR(255),
	F7 NVARCHAR(255),
	F8 SMALLDATETIME
)
GO

CREATE VIEW [Task Tracking Task]
AS	
SELECT	t.Task_Sk AS TaskID,
		p.Project_Sk AS ProjectID,
		t.TaskName,
		t.TaskTypeLookup_Sk AS TaskTypeID,
		t.TaskStatusLookup_Sk AS TaskStatusID,
		NULL AS TaskPriority_Lookup,
		t.TaskDescription,
		NULL AS CurrentUserID,
		NULL AS AssignedToUserID,
		NULL AS AssignedToRoleID,
		NULL AS EstimateDuration,
		NULL AS EstimateCompletionDate,
		t.CreatedDate,
		t.CreatedPerson_Sk AS CreatedUserID,
		ISNULL(t.LastModifiedDate, t.CreatedDate) AS CreatedModifiedDateTime,
		ISNULL(t.LastModifiedPerson_Sk, t.CreatedPerson_Sk) AS CreatedModifiedUserID
FROM	PROJECT.Task t
			JOIN PROJECT.Project p ON t.Project_Sk = p.Project_Sk

GO

CREATE VIEW TaskType
AS	
SELECT	l.LookupElement_Sk AS TaskTypeID,
		l.LookupElementName AS TaskTypeName 
FROM	COMMON.LookupElement l
			JOIN COMMON.LookupCategory lc ON lc.LookupCategory_Sk = l.LookupCategory_Sk
WHERE	lc.LookupCategoryName = 'TaskType'
GO

CREATE VIEW TaskTypeStatus 
AS	
SELECT	NULL AS TaskStatusID,
		NULL AS TaskTypeID,
		NULL AS IsStatusTypeOpen,
		NULL AS StatusName,
		NULL AS Sequence
GO

CREATE VIEW [User] 
AS	
SELECT	p.Person_Sk AS UserID,
		p.UserName,
		p.Person_Sk AS ContactID,
		p.EmployeeTypeLookup_Sk AS UserType_Lookup,
		NULL as AuthenticationType_Lookup,
		NULL AS UserPassword,
		p.IsAdmin AS IsAdministrator,
		p.IsActive,
		p.HireDate AS ActiveDate,
		NULL AS InactiveDate,
		1 AS IsBillable
FROM	EMPLOYEE.Person p
GO

--Old Model views
CREATE VIEW [dbo].[ActivityUser_vw]
AS
SELECT	a.*, 
		c.FirstName + ' ' + c.LastName AS UserName
FROM	dbo.Activity a INNER JOIN
			dbo.[User] u ON a.UserID = u.UserID INNER JOIN
			dbo.Contact c ON u.ContactID = c.ContactID
GO

CREATE VIEW [dbo].[BaseReportView]
AS
SELECT	c.ClientID, 
		c.ClientName, 
		p.ProjectID, 
		p.ProjectName, 
		p.ParentProjectID, 
		p.ProjectStatus_Lookup AS ProjectStatus, 
		t .TaskID, 
		t .TaskName, 
		a.UserID, 
        ct.firstname + ' ' + ct.lastname AS UserName, 
		a.ActivityID, 
		a.ActivityDescription, 
		a.DurationTaken AS Duration, 
		a.IsBillable, 
		a.ActivityDate, 
        CASE WHEN (a.IsBillable = 1) THEN a.DurationTaken ELSE 0 END AS BillableDuration, 
		CASE WHEN (a.IsBillable = 0) THEN a.DurationTaken ELSE 0 END AS NonBillableDuration
FROM	dbo.Client c LEFT OUTER JOIN
			dbo.Project p ON c.ClientID = p.ClientID LEFT OUTER JOIN
			dbo.Task t ON p.ProjectID = t .ProjectID LEFT OUTER JOIN
			dbo.Activity a ON t .TaskID = a.TaskID INNER JOIN
			dbo.[USER] u ON a.userid = u.userid INNER JOIN
			dbo.contact ct ON ct.contactid = u.contactid
GO

CREATE VIEW [dbo].[ClientProject_vw]
AS
SELECT	dbo.Client.ClientID, 
		dbo.Client.ClientName, 
		dbo.Client.ClientType_Lookup, 
		dbo.Client.ClientStatus_Lookup, 
		dbo.AccessControl.UserID,
		dbo.Project.ParentProjectID, 
		dbo.Project.ProjectName, 
		dbo.Project.ProjectStatus_Lookup, 
		dbo.Project.ProjectType_Lookup, 
		dbo.Project.EstimateCompletionDate, 
		dbo.Project.EstimateDuration, 
		dbo.Project.CreatedModifiedDateTime, 
		dbo.Project.CreatedModifiedUserID, 
		dbo.Project.ProjectID, 
		dbo.Project.IsBillable
FROM	dbo.AccessControl INNER JOIN
			dbo.Project ON dbo.AccessControl.ProjectID = dbo.Project.ProjectID RIGHT OUTER JOIN
			dbo.Client ON dbo.Project.ClientID = dbo.Client.ClientID
GO

CREATE VIEW [dbo].[ClientProject_vw2]
AS
SELECT	dbo.Client.ClientID, 
		dbo.Client.ClientName, 
		dbo.Client.ClientType_Lookup, 
		dbo.Client.ClientStatus_Lookup, 
		dbo.Project.ParentProjectID, 
		dbo.Project.ProjectName, 
		dbo.Project.ProjectStatus_Lookup, 
		dbo.Project.ProjectType_Lookup, 
		dbo.Project.EstimateCompletionDate, 
		dbo.Project.EstimateDuration, 
		dbo.Project.CreatedModifiedDateTime, 
		dbo.Project.CreatedModifiedUserID, 
		dbo.Project.ProjectID
FROM	dbo.Project RIGHT OUTER JOIN
			dbo.Client ON dbo.Project.ClientID = dbo.Client.ClientID
GO

CREATE VIEW [dbo].[ClientProjectAdmin_vw]
AS
SELECT	dbo.Client.ClientID, 
		dbo.Client.ClientName, 
		dbo.Client.ClientType_Lookup, 
		dbo.Client.ClientStatus_Lookup, 
		dbo.Project.ParentProjectID, 
		dbo.Project.ProjectName, 
		dbo.Project.ProjectStatus_Lookup, 
		dbo.Project.ProjectType_Lookup, 
		dbo.Project.EstimateCompletionDate, 
		dbo.Project.EstimateDuration, 
		dbo.Project.CreatedModifiedDateTime, 
		dbo.Project.CreatedModifiedUserID, 
		dbo.Project.ProjectID
FROM	dbo.Project RIGHT OUTER JOIN
			dbo.Client ON dbo.Project.ClientID = dbo.Client.ClientID
GO

CREATE VIEW [dbo].[ContactUser_vw]
AS
SELECT	dbo.[User].UserID, 
		dbo.[User].UserName, 
		dbo.[User].UserType_Lookup, 
		dbo.[User].AuthenticationType_Lookup, 
		dbo.[User].UserPassword,
		dbo.[User].IsAdministrator, 
		dbo.[User].IsActive, 
		dbo.Contact.ContactID, 
		dbo.Contact.ClientID, 
		dbo.Contact.FirstName, 
		dbo.Contact.LastName, 
		dbo.Contact.Email, 
		dbo.Contact.PhoneNumber, 
		dbo.Contact.FaxNumber, 
		dbo.Contact.CellPhone
FROM	dbo.Contact LEFT OUTER JOIN
			dbo.[User] ON dbo.Contact.ContactID = dbo.[User].ContactID
GO

CREATE VIEW [dbo].[OldReportView]
AS
SELECT	TOP 100 PERCENT c.ClientID AS ClientID, 
		c.ClientName AS ClientName, 
		p.ProjectID AS ProjectID, 
		p.ProjectName AS ProjectName, 
		p.ProjectStatus_Lookup AS ProjectStatus, 
		p.EstimateDuration AS ProjectEstimate, 
		t.TaskID AS TaskID, 
		t.TaskName AS TaskName, 
		t.EstimateDuration AS TaskEstimate, 
		a.UserID AS UserID, 
		a.DurationTaken AS Duration, 
		a.IsBillable AS IsBillable, 
		a.ActivityDate AS ActivityDate
FROM	dbo.Client c INNER JOIN
			dbo.Project p ON c.ClientID = p.ClientID INNER JOIN
			dbo.Task t ON p.ProjectID = t.ProjectID INNER JOIN
			dbo.Activity a ON t.TaskID = a.TaskID
ORDER BY c.ClientName, p.ProjectName, t.TaskName
GO

CREATE VIEW [dbo].[projectuser_vw]
AS
SELECT	dbo.Project.ProjectID, 
		dbo.AccessControl.UserID, 
		dbo.Project.ProjectStatus_Lookup
FROM	dbo.Project INNER JOIN
			dbo.AccessControl ON dbo.Project.ProjectID = dbo.AccessControl.ProjectID
GO

CREATE VIEW [dbo].[ReportEstimateView]
AS
SELECT	c.ClientID AS ClientID, 
		c.ClientName AS ClientName, 
		p.ProjectID AS ProjectID, 
		p.ProjectName AS ProjectName, 
		p.ParentProjectID AS ParentProjectID,
		p.ProjectStatus_Lookup AS ProjectStatusID, 
		l.LookupElementName AS ProjectStatus, 
		p.EstimateDuration AS ProjectEstimate, 
		t.TaskID AS TaskID, 
		t.TaskName AS TaskName, 
		t.EstimateDuration AS TaskEstimate
FROM	Client c, 
		Project p, 
		Task t, 
		LookupElement l
WHERE	t.ProjectID = p.ProjectID AND
		p.ClientID = c.ClientID AND
		p.ProjectStatus_Lookup = l.LookupElementID
GO

CREATE VIEW [dbo].[task_vw]
AS
SELECT	dbo.TaskTypeStatus.IsStatusTypeOpen AS IsStatusTypeOpen, 
		dbo.TaskTypeStatus.StatusName AS StatusName, 
		dbo.Project.ProjectName AS ProjectName, 
		dbo.Client.ClientName AS ClientName, 
		dbo.Client.ClientID AS ClientID, dbo.Task.*
FROM	dbo.Task INNER JOIN
			dbo.TaskTypeStatus ON dbo.Task.TaskStatusId = dbo.TaskTypeStatus.TaskStatusID INNER JOIN
			dbo.Project ON dbo.Task.ProjectID = dbo.Project.ProjectID INNER JOIN
			dbo.Client ON dbo.Project.ClientID = dbo.Client.ClientID
GO

CREATE VIEW [dbo].[v_OakwoodReport]
AS
SELECT	*
FROM	dbo.BaseReportView
WHERE	(ActivityDate > '9/1/2004') AND 
		(ActivityDate < '10/1/2004') AND 
		(ClientID = 15) AND 
		(ProjectID = 64)
GO