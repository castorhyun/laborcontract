pragma solidity ^0.4.26;
//pragma experimental ABIEncoderV2;


contract LaborContract{
    
    address public contractAddress;
    
    
    struct employer_S{
        
        string businessRegistrationNumber;
        string companyName;
        string login_id;
        
        address rg_address;
    }
    
    struct employee_S{
        
        string socialRegistrationNumber;
        string personName;
        string login_id;
        
        address rg_address;
    }
    
    struct laborContract_S{
        
        //사업자등록번호, 계약기간, 근무장소, 근로시간, 
        //임금형태 및 금액, 임금지급일, 지급방법, 사회보험 적용여부, 근로자아이디, 계약서의 해시값
        
        bool contracted;
        bool finished;
        
        employer_S cont_employer;
        employee_S cont_employee;
        
        uint fr_date;
        uint to_date;
        uint st_time;
        uint en_time;
        
        string salary_type;
        string salary_amt;
        
        bool social_insurance;
        
        //uint paymentDay;
        //string paymentMethod;
        

    }
    

    mapping( address => employee_S) public employeeM;
    mapping( address => employer_S) public employerM;
    mapping( address => laborContract_S) public LBcontractM;
    
    
    //Constructor function
    function LaborContract() public{
        
        contractAddress = msg.sender;
        LBcontractM[contractAddress].contracted = false;
        LBcontractM[contractAddress].finished = false;
        
    }
    
    // Make an employer Account
    function employerAccount(address _address, string _businessRegistrationNumber, string _companyName , string _login_id) public{
        
        employerM[_address].rg_address = _address;
        employerM[_address].businessRegistrationNumber = _businessRegistrationNumber;
        employerM[_address].companyName = _companyName;
        employerM[_address].login_id = _login_id;       

    }
    
    // Make an employee Account
    function employeeAccount(address _address, string _socialRegistrationNumber, string _personName, string _login_id) public {

        employeeM[_address].rg_address = _address;
        employeeM[_address].socialRegistrationNumber = _socialRegistrationNumber;
        employeeM[_address].personName = _personName;
        employeeM[_address].login_id = _login_id;        
        
        
    }
    
    
    //  노동자 정보예시
    //  rg_address      0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db
    //  외국인등록번호  8803037877873
    //  노동자명        Wian Cris
    //  로그인ID        근로자77


    //  고용주 정보
    //  rg_address      0x14723a09acff6d2a60dcdf7aa4aff308fddc160c
    //  사업자번호      83776382929282  
    //  사업자명        정밀모터스공장
    //  로그인ID        고용주10
    
    
    // Contract Address 0xca35b7d915458ef540ade6068dfe2f44e8fa733c
    
    // Make a LaborContract
    function makeContract(address _employee, address _employer, uint fr_date, uint to_date, uint st_time, uint en_time,
                        string salary_type, string salary_amt, bool social_insurance, uint paymentDay, string paymentMethod) public{
        
        require( employerM[_employer].rg_address == _employer);
        require( employeeM[_employee].rg_address == _employee);
        
        LBcontractM[contractAddress].contracted = true;
        LBcontractM[contractAddress].finished = false;
        LBcontractM[contractAddress].cont_employer = employerM[_employer];
        LBcontractM[contractAddress].cont_employee = employeeM[_employee];
        
        LBcontractM[contractAddress].fr_date = fr_date;
        LBcontractM[contractAddress].to_date = to_date;
        LBcontractM[contractAddress].st_time = st_time;
        LBcontractM[contractAddress].en_time = en_time;
        
        LBcontractM[contractAddress].salary_type        = salary_type;
        LBcontractM[contractAddress].salary_amt         = salary_amt;
        LBcontractM[contractAddress].social_insurance   = social_insurance;
        //LBcontractM[contractAddress].paymentDay         = paymentDay;
        //LBcontractM[contractAddress].paymentMethod      = paymentMethod;
        
        
        
    }
    
    function getContractInfo() view returns (bool, bool, uint, uint, uint,uint, string, string, bool) {
        
        return (LBcontractM[contractAddress].contracted, 
                LBcontractM[contractAddress].finished,
                LBcontractM[contractAddress].fr_date, 
                LBcontractM[contractAddress].to_date, 
                LBcontractM[contractAddress].st_time,
                LBcontractM[contractAddress].en_time,
                LBcontractM[contractAddress].salary_type,
                LBcontractM[contractAddress].salary_amt,
                LBcontractM[contractAddress].social_insurance);
    }
    


    
}
