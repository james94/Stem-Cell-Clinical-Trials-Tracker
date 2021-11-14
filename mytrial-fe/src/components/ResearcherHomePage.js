import { Link } from "react-router-dom";

const ResearcherHomePage = () => {
    return (
        <div style={{ marginLeft: "10px" }}>
            <button><Link to='/trials'>My Trials</Link></button>
            <button><Link to='/addtrial'>Create New Trial</Link></button>
            <button>My Watchlists</button>
            <button><Link to="/discussion">Discussion</Link></button>
            <button><Link to="/patient">Patient List</Link></button>
            <button><Link to="/researcher">Researcher List</Link></button>
        </div>
    )
}

export default ResearcherHomePage;