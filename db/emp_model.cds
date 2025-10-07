using {
    cuid,
    managed
} from '@sap/cds/common';
using {gopi.commons} from './utils/commons';

namespace my_first_btp_app.db.data.emp_model;


entity Employees : cuid, managed { // cuid adds a primary key field named ID of type String(36)
    // key NODE_KEY : cuid; // primary key
    EmpName   : String(100);
    // EmpDept  : String(40); // this creates a foreign key in Employees entity
    EmpLevel  : String(100);
    EmpDOJ    : Date;
    EmpEmail  : String(100);
    EmpPhone  : String(15);
    EmpSalary : Decimal(15, 2);
    DEP_GUID  : Association to Departments;
//  EmpDeptID : String(10); // this creates a foreign key in Employees entity
// EmpDeptID is the foreign key in Employees entity referring to Departments entity
}

// DeptEmpList is array of Employees in Departments entity
entity Departments : managed {
    key NODE_KEY    : commons.Guid; // primary key, this is UUID not auto generated
        DeptName    : String(100);
        // DeptName    : Association to many Employees // this reverses the association in Employees entity
        //                   on DeptName.EmpDept = $self; // EmpDeptId is foreign key in employees entity
        DeptDesc    : String(255);
        DeptArea    : String(100);
        DeptMgr     : String(100);
        DeptEmpList : Association to many Employees // this reverses the association in Employees entity
                          on DeptEmpList.DEP_GUID = $self; // EmpDeptId is foreign key in employees entity
// $self refers to current entity (Departments in this case)
}
