import {Link} from "react-router-dom"; 

const ResearcherHomePage = () => {
    return (
        <div>
            <button><Link path='/trials'>My Trials</Link></button>
            <button><link path='/addtrial'>Create New Trial</link></button>
            <button>My Watchlists</button>
            <button>Discussion Forum</button> 
        </div>
    ) 
}

export default ResearcherHomePage;