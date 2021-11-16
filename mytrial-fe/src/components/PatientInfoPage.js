import React from 'react';
import { Link } from 'react-router-dom';
import { Button } from "semantic-ui-react";
import PatientService from '../service/PatientService';
import { withRouter } from "react-router";
import queryString from 'query-string';

class PatientInfoPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            researcher_id: "000000052",
            patientToShow: {},
            trialToShow: {},
            researcherToShow: {},
            // researcher_id: localStorage.getItem('id')
        };
    }

    deletePatient = (event, patient_id) => {
        alert('Deleting Patient: ' + patient_id + '; Heading to Trials Page');

        PatientService.deletePatient(patient_id)
            .then(data => {
                // pass whole history obj to our component as properties with help from withRouter
                const { history } = this.props;
                if(history) {
                    // http://localhost:3001/patient?trial_id=000000001
                    history.push("/trials");
                }
            })
            .catch(err => {
                console.log(err);
            })
    }

    render() {

        return (
            <div>
                {
                    (this.state.donor) ?
                        <h2>Donor: {this.state.donor.name}</h2> :
                        <Link to="#">
                            <Button>Add Donor</Button>
                        </Link>
                }
                <h2>Patient Data</h2>
                <pre>
                    {JSON.stringify(this.state.patientToShow, null, 2)}
                </pre>
                {/* go to disease page */}

                <hr />
                {/* go to trial page */}
                <h2>Trial Data</h2>
                {<Link to={{ pathname: `/trials/${this.state.trialToShow.trial_id}` }}>{this.state.trialToShow.title}</Link>}
                <pre>
                    {JSON.stringify(this.state.trialToShow, null, 2)}
                </pre>
                <hr />
                {/* go to researcher page */}
                <h2>Researcher Data</h2>
                {<Link to={{ pathname: `/researcher/${this.state.researcherToShow.researcher_id}` }}>{this.state.researcherToShow.r_name}</Link>}
                <pre>
                    {JSON.stringify(this.state.researcherToShow, null, 2)}
                </pre>
                <Button>
                    <Link to={`/editPatient/${this.props.match.params.id}`}>Edit Profile</Link>
                </Button>
                    {localStorage.getItem('role') === 'researcher' && <Button onClick={(event) => { this.deletePatient(event, this.props.match.params.id) }}>Delete Patient</Button>}
            </div>
        )
    }

    componentDidMount() {
        let config = {
            headers: {
                researcher_id: localStorage.getItem('id')
            }
        };
        PatientService.getPatientById(this.props.match.params.id, config)
            .then(data => {
                // this.setState({ ...data.data });
                var { p_username, p_password, trial, researcher, ...patientToShow } = data.data;
                this.setState({ patientToShow: patientToShow });
                this.setState({ trialToShow: data.data.trial });
                var { r_username, r_password, ...researcherToShow } = data.data.researcher;
                this.setState({ researcherToShow: researcherToShow });
            })
            .catch(err => {
                console.log(err)
            })
    }
}

export default withRouter(PatientInfoPage);