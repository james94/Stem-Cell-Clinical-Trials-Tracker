import {Link} from "react-router-dom"; 

const ResearcherHomePage = () => {
    return (
        <div>
            <button><Link path='/trials'>My trials</Link></button>
            <button>My watchlists</button>
            <button>Discussion Forum</button>
        </div>
    )
}

export default ResearcherHomePage;