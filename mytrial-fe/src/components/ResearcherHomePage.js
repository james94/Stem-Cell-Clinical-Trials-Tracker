import { Link } from "react-router-dom";

const ResearcherHomePage = () => {
    return (
        <div style={{ marginLeft: "10px" }}>
            <button><Link to='/trials'>My Trials</Link></button>
            <button>My Watchlists</button>
            <button><Link to="/discussion">Discussion</Link></button>
            <button><Link to="/researcher">Researcher List</Link></button>
            <button><Link to="/grants_list">Grants List</Link></button>
            <button><Link to="/searchpatients">Search Patients</Link></button>
        </div>
    )
}

export default ResearcherHomePage;