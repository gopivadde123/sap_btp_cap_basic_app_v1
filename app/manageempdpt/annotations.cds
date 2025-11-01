using EmployeeService as service from '../../srv/EmployeeService';

annotate service.Employees with @(
    // this is for the filter bar
    UI.SelectionFields:[
        EmpName,
        EmpLevel,
        EmpDOJ,
        EmpEmail,
        EmpPhone,
        DEP_GUID.DeptArea,
    ],
    // this is for the Table columns
    UI.LineItem:[
    {
        $Type : 'UI.DataField',
        Value: ID,
    },
    {
        $Type : 'UI.DataField',
        Value : EmpName,
    },
    {
        $Type : 'UI.DataField',
        Value : EmpEmail,
    },
    {
        $Type : 'UI.DataFieldForAction',
        Label: 'Hike',
        Inline : true,
        Action : 'Employees.hikeSalary',
    },
    {
        $Type : 'UI.DataField',
        Value : EmpSalary,
    },
    {
        $Type : 'UI.DataField',
        Value : DEP_GUID.DeptName,
    },
    {
        $Type : 'UI.DataField',
        Value : EmpLevel,
    },
    {
        $Type : 'UI.DataField',
        Value : EmpPhone,
    },
    {
        $Type : 'UI.DataField',
        Criticality:IconColor,
        Value : DName,
    },
],
// This is for the table header ex: The Employees(7)
 UI.HeaderInfo:{
    TypeName: 'Employees',
    TypeNamePlural: 'The Employees',
    // for the title for the object page
    Title: { Value : ID},
    Description:{ Value:DEP_GUID.DeptArea},
    ImageUrl:'data:image/jpeg;base64,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'
 },
 UI.Facets: [
    {
        $Type : 'UI.CollectionFacet',
        Label: 'Additional Info',
        Facets:[
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Employee Details',
                Target : '@UI.Identification',
            },
              {
                $Type : 'UI.ReferenceFacet',
                Label : 'Employee Address',
                Target : '@UI.FieldGroup#Spiderman',
            },
             {
                $Type : 'UI.ReferenceFacet',
                Label : 'Emp Contact Information',
                Target : '@UI.FieldGroup#Superman',
            }
        ]
    }
    
 ],
 // this can add only one for the 
 UI.Identification: [
    {
        $Type : 'UI.DataField',
        Value : ID,
    },
     {
        $Type : 'UI.DataField',
        Value : EmpName,
    },
    {
        $Type : 'UI.DataField',
        Value : DEP_GUID_NODE_KEY,//give the Department ID valuehelp
    },
     {
        $Type : 'UI.DataField',
        Value : EmpLevel,
    }
 ],
 // can add multiple fieldgroups
 UI.FieldGroup #Spiderman:{
  Label : 'Emp Add Details',
  Data : [
    {
    $Type : 'UI.DataField',
    Value : EmpDOJ,
    },
    {
        $Type : 'UI.DataFieldForAction',
        Label : 'GV Submit',
        Action : 'EmployeeService.setChangeDefaultDOJ'
    },
    {
    $Type : 'UI.DataField',
    Value : EmpEmail
    }
  ]
 },
 UI.FieldGroup #Superman:{
    Label : 'Emp Contcat info',
    Data : [
        {
            $Type : 'UI.DataField',
            Value : EmpPhone,
        },
         {
            $Type : 'UI.DataField',
            Value : EmpSalary,
        },
         {
            $Type : 'UI.DataField',
            Value : DEP_GUID_NODE_KEY,
        }
    ]
 }
);

annotate service.Departments with @(
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : DeptArea,
        },
        {
            $Type : 'UI.DataField',
            Value : DeptDesc,
        },
        {
            $Type : 'UI.DataField',
            Value : DeptMgr,
        },
        {
            $Type : 'UI.DataField',
            Value : DeptEmpList.EmpName,
        }
         
    ],
    UI.HeaderInfo:{
        TypeName: 'Department Item',
        TypeNamePlural: 'The Departments Items',
        Title : {Value : DeptEmpList.EmpName},
        Description: {Value.DeptEmpList.EmpDept}

    },
    UI.Facets: [
        {
        $Type : 'UI.ReferenceFacet',
        Label : 'Item Details',
        Target : '@UI.Identification',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Additional Department Details', 
            Target : '@UI.FieldGroup#DeptInfo'
        }

    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : DeptArea,
        },
         {
            $Type : 'UI.DataField',
            Value : DeptDesc,
        },
         {
            $Type : 'UI.DataField',
            Value : DeptEmpList.EmpName,
        }
    ],
    UI.FieldGroup#DeptInfo:{
        Label : 'Department info',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : DeptDesc,
            },
            {
                $Type : 'UI.DataField',
                Value : DeptArea,
            },
            {
                $Type : 'UI.DataField',
                Value : DeptMgr,
            },
        ]
    }
);






