import React from 'react';
import { Link, withRouter } from 'react-router-dom';
import { Button } from 'semantic-ui-react';
import PatientService from '../service/PatientService';
import queryString from 'query-string';

class PatientPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            patients: [],
            researcher_id: localStorage.getItem('id'),
            role: localStorage.getItem('role'),
            trial_id: queryString.parse(this.props.location.search).trial_id
        };
    }

    render() {
        return (
            <div>
                {/* patient list */}
                <ul>
                    {
                        this.state.patients.map((e, i) =>
                            <li key={i}>
                                <Link to={{ pathname: `/patient/${e.patient_id}` }}>
                                    Patient{e.patient_id}
                                </Link>
                            </li>)
                    }
                </ul>
                <Link to='#'>
                    <Button>Add Patient</Button>
                </Link>
            </div>
        )
    }

    componentDidMount() {
        let config = {
            headers: {
                researcher_id: this.state.researcher_id,
                trial_id: this.state.trial_id
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

export default withRouter(PatientPage);
