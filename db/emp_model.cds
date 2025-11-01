using {
    cuid,
    managed
} from '@sap/cds/common';
using {gopi.commons} from './utils/commons';

namespace my_first_btp_app.db.data.emp_model;


entity Employees : cuid, managed { // cuid adds a primary key field named ID of type String(36)
    // key NODE_KEY : cuid; // primary key
    EmpName   : String(100) @title : '{i18n>XLBL_EMPNAME}';
    // EmpDept  : String(40); // this creates a foreign key in Employees entity
    EmpLevel  : String(100) @title : '{i18n>XLBL_EMPLEVEL}';
    EmpDOJ    : Date @title : '{i18n>EMP_DOJ}';
    EmpEmail  : String(100) @title : '{i18n>EMP_EMAIL}';
    EmpPhone  : String(15) @title : '{i18n>EMP_PHONE}';
    EmpSalary : Decimal(15, 2) @title : '{i18n>EMP_SALARY}';
    DEP_GUID  : Association to Departments @title : '{i18n>DEP_GUID}';
//  EmpDeptID : String(10); // this creates a foreign key in Employees entity
// EmpDeptID is the foreign key in Employees entity referring to Departments entity
}

// DeptEmpList is array of Employees in Departments entity
entity Departments : managed {
    key NODE_KEY    : commons.Guid; // primary key, this is UUID not auto generated
        DeptName    : String(100) @title : '{i18n>DEP_NAME}';
        // DeptName    : Association to many Employees // this reverses the association in Employees entity
        //                   on DeptName.EmpDept = $self; // EmpDeptId is foreign key in employees entity
        DeptDesc    : String(255) @title : '{i18n>DEP_DESC}';
        DeptArea    : String(100) @title : '{i18n>DEP_AREA}';
        DeptMgr     : String(100) @title : '{i18n>DEP_MANGR}';
        DeptEmpList : Association to many Employees // this reverses the association in Employees entity
                          on DeptEmpList.DEP_GUID = $self; // EmpDeptId is foreign key in employees entity
// $self refers to current entity (Departments in this case)
}
