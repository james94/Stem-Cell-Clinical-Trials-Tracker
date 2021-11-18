// SJSU CMPE 138 Fall 2021 TEAM1
import React from 'react';
import { Link } from 'react-router-dom';
import { Button } from "semantic-ui-react";
import PatientService from '../service/PatientService';
import { withRouter } from "react-router";
import DonorService from "../service/DonorService";

class PatientInfoPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            researcher_id: localStorage.getItem("id"),
            patientToShow: {},
            trialToShow: {},
            researcherToShow: {},
            donor: null
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

    retrieveDonorByPatientId = () =>{
        DonorService.getDonorByPatientId(this.props.match.params.id)
            .then(response => {
                console.log(response.data)
                this.setState({
                    donor: response.data
                });
            })
            .catch(err => {
                console.log(err)
            })

            console.log(this.state.donor);
    }

    render() {

        return (
            <div>

                {  // shows Update Donor button if patient has a donor and role is researcher, else shows Add Donor button
                    (this.state.donor && localStorage.getItem('role') === 'researcher') ?
                        <Button><Link to={{pathname: `/update_donor/${this.props.match.params.id}`}}>Update Donor</Link></Button> :
                        <Button><Link to={{pathname:`/add_donor/${this.props.match.params.id}`}}>Add Donor</Link></Button>
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

        this.retrieveDonorByPatientId();
    }
}

export default withRouter(PatientInfoPage);
