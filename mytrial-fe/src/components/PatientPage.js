import React from 'react';
import { Link } from 'react-router-dom';
import PatientService from '../service/PatientService';

class PatientPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            patients: [],
            researcher_id: "000000052"
            // researcher_id: localStorage.getItem('id')
        };
    }

    render() {
        return (
            <div>
                {/* patient list */}
                <ul>
                    {this.state.patients.map((e, i) => <li key={i}><Link to={{ pathname: `/patient/${e.patient_id}` }}>Patient{e.patient_id}</Link></li>)}
                </ul>
            </div>
        )
    }

    componentDidMount() {
        let config = {
            headers: {
                researcher_id: this.state.researcher_id
            }
        };
        // show discussion list
        PatientService.getPatients(config)
            .then(data => {
                this.setState({
                    patients: data.data
                });
            })
            .catch(err => {
                console.log(err)
            })
    }
}

export default PatientPage;