import { Link } from "react-router-dom";

const ResearcherHomePage = () => {
    return (
        <div style={{ marginLeft: "10px" }}>
            <button><Link to='/trials'>My Trials</Link></button>
            <button><Link to="/rwatchlist">My Watchlists</Link></button>
            <button><Link to="/discussion">Discussion</Link></button>
            <button><Link to="/researcher">Researcher List</Link></button>
            <button><Link to="/searchpatients">Search Patients</Link></button>
            <button><Link to="/search">Search Patients by Disease</Link></button>
        </div>
    )
}

export default ResearcherHomePage;