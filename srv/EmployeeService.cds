// Import the CDS data model for employees and departments from the specified path,
// alias it as 'my' to enable concise references in projections below.
using {my_first_btp_app.db.data.emp_model as my} from '../db/emp_model';


// Define the EmployeeService OData service, which provides APIs for employees and departments.
// The @(requires: 'authenticated-user') annotation makes all operations within this service
// accessible only to authenticated users, ensuring basic endpoint security.
service EmployeeService @(requires: 'authenticated-user') {

    // Expose the Employees entity as a service endpoint with additional access control.
    // The @(restrict:[...]) annotation applies field-level authorization by:
    // - Allowing only users with 'Viewer', 'Editor', or 'Admin' roles to access full CRUD and PATCH operations
    // - Further restricting access so users only see or edit employee records that match their own EmpLevel
    // Using 'projection' helps provide a controlled view instead of the full database schema.
    entity Employees @(restrict: [{
        grant: ['*' // Full CRUD and PATCH permissions
        ],
        to   : [
            'Viewer',
            // Read-only users
            'Editor',
            // Can modify data
            'Admin' // Full access users
        ],
        where: 'EmpLevel = $user.EmpLevel' // Row-level filter: only see/edit employees at the user's level
    }])                as projection on my.Employees
        actions {
            // Define a custom instance-bound action for employees to increase salary.
            // This action is typically triggered via a user interface on a specific employee record
            // and returns the updated employee entity after the salary hike is applied.
            action hikeSalary() returns Employees;
        };

    // Expose the Departments entity similarly through a projection,
    // enabling safe read and/or management of department data via this service.
    entity Departments as projection on my.Departments;

    // Provide a function to retrieve the employee with the highest salary.
    // Returns a single employee record, useful for dashboards, analytics, or recognition use cases.
    function empHighSalary() returns Employees;
}
