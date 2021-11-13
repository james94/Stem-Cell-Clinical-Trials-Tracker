import { Link } from 'react-router-dom';

const PatientHomePage = () => {
    return (
        <div>
            <button>My Trial</button>
            <button><Link to={'/pwatchlists/' + localStorage.getItem('id')}>Watchlists</Link></button>
        </div>
    )
}

export default PatientHomePage;