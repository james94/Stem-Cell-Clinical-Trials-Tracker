import {Link} from "react-router-dom"; 

const ResearcherHomePage = () => {
    return (
        <div style={{marginLeft: "10px"}}>
            <button><Link to='/trials'>My Trials</Link></button>
            <button><Link to='/addtrial'>Create New Trial</Link></button>
            <button>My Watchlists</button>
            <button>Discussion Forum</button> 
        </div>
    ) 
}

export default ResearcherHomePage;