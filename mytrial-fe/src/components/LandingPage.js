import {Link} from "react-router-dom";

const LandingPage = () => {
    return (
        <div>
            Select your role:
            <ul>
                <li>
                    <button onClick={() => {localStorage.setItem('role', 'researcher')}}><Link to="/login">Researcher</Link></button>
                </li>
                <li>
                    <button onClick={() => {localStorage.setItem('role', 'patient')}}><Link to="/login">Patient</Link></button>
                </li>
                
            </ul>
        </div>
    )
}

export default LandingPage;