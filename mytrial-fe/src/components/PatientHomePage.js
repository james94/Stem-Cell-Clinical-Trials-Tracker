import { Link } from 'react-router-dom';

const PatientHomePage = () => {
    return (
        <div style={{ marginLeft: "10px" }}>
            <button><Link to='/trials'>My Trial</Link></button>
            <button><Link to={'/pwatchlists/' + localStorage.getItem('id')}>Watchlists</Link></button>
        </div>
    )
}

export default PatientHomePage;