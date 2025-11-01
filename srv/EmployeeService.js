const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {
  const { Employees, Departments } = this.entities;
  // const { user } = cds.context; // Move here
  // this.on("READ", Employees, async (req) => {
  //   console.log("Custom handler for reading Employees", req.user);
  //   // const tx = cds.tx(req);
  //   // const employees = await tx.run(SELECT.from(Employees).columns("ID", "firstName", "lastName", "email", "department_ID"));
  //   // return employees;
  // });
  // Example: Adding a simple event handler for reading Employees
  // this.on('READ', Employees, async (req) => {
  //     const employees = await cds.tx(req).run(SELECT.from(Employees));
  //     return employees;
  // });
  // this.on("READ", Employees, (req, res) => {
  //   console.log(`Employee with ID ${res} has been updated.`);
  // });
  // this.on("READ", Employees, async (req) => {
  //   const employees = await cds.tx(req).run(SELECT.from(Employees));
  //   console.log("Employees data:", employees); // This will log the actual data
  //   return employees;
  // });
  this.after("READ", Employees, (req, res) => {
    // console.log(
    //   "After READ hook triggered for Employees" + JSON.stringify(res)
    // );
    if (res && res.results && res.results.length > 1) {
      res.results.forEach((employee) => {
        if (employee.EmpDOJ != null) {
          const date = new Date("2021-07-12");
          const options = { year: "numeric", month: "long", day: "numeric" };
          const formatted = date.toLocaleDateString("en-US", options);
          employee.EmpDOJ = formatted;
        }
        if (employee.EmpLevel === "Mid-Emp") {
          employee.EmpLevel = "2";
        }
        if (employee.EmpPhone != null) {
          const phoneNumber = "8136478970";
          const formatted = phoneNumber.replace(
            /(\d{3})(\d{3})(\d{4})/,
            "$1-$2-$3"
          );
          employee.EmpPhone = formatted;
        }
      });
    }
  });
  this.before(["UPDATE", "CREATE"], Employees, (req, res) => {
    if (req.data && req.data.EmpName) {
      req.data.EmpName = req.data.EmpName + " - updated";
    }
  });
  // this.on("READ", Employees, async (req) => {
  //   return await this.read(Employees);
  // });
  // instance bound action
  // this.on("hikeSalary", async (req, res) => {
  //   try {
  //     // programatically check @ runtime, if user have the Editor permission
  //     req.user.is("Editor") || req.reject(403); // true or false
  //     const tx = req.params[0]; // assuming the first parameter is the transaction amount
  //     console.log("Transaction Amount:", tx);
  //   } catch (error) {
  //     return "Hey you are not authorized to do this action" + error.toString();
  //   }
  // });
  // Handler for custom function to get the employee with the highest salary
  this.on("empHighSalary", async (req, res) => {
    try {
      // Start a transaction scoped to this request for data integrity
      const tx = cds.tx(req);

      // Query the Employees entity, sorting by EmpSalary descending,
      // and limit the result to the top employee (highest salary)
      const myData = await tx
        .read(Employees)
        .orderBy({ EmpSalary: "desc" })
        .limit(1);

      // Return the result (employee with the highest salary)
      return myData;
    } catch (error) {
      // On any error, return a string describing the error
      return "Error occurred" + error.toString();
    }
  });
  // Handler for instance-bound action to hike an employee's salary
  this.on("hikeSalary", async (req, res) => {
    try {
      // Ensure only users with the 'Editor' role can perform this action
      // If not, reject request with 403 Forbidden
      req.user.is("Editor") || req.reject(403);

      // Begin a transaction for atomicity
      const tx = cds.tx(req);

      // Update EmpSalary for the targeted employee (from req.subject) by adding 5000
      await tx.update(req.subject).with({
        EmpSalary: { "+=": 5000 },
      });

      // Read back the updated employee record to return latest state
      const replay = await tx.read(req.subject);
      return replay;
    } catch (error) {
      // Return error info if anything fails during processing
      return "Error occurred" + error.toString();
    }
  });
  // implementation of the function, gives default date
  this.on('getEmpDojDefault', async (req,res) => {
    try {
     return { EmpDOJ: '2025-10-24' }; // this set default date
    } catch (error){
      return "Hey error !"+ error.toString();
    }
  });
  // implementing function for default date of join
  // when click on button...
  this.on('setChangeDefaultDOJ', async (req,res)=>{
    try{
     return {EmpDOJ: '2021-08-22'};
    }catch(error){
      return "hey error"+error.toString();
    }
  });
});
