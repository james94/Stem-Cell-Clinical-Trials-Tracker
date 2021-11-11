import { Link } from 'react-router-dom';

const PatientHomePage = () => {
    return (
        <div>
            <button><Link path='/trials'>My Trial</Link></button>
            <button>Watchlists</button>
        </div>
    )
}

export default PatientHomePage;