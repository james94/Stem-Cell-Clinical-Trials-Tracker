import React from 'react';
// import { Link } from 'react-router-dom';
import PatientService from '../service/PatientService';
import {Button} from "semantic-ui-react";
import {Link} from "react-router-dom";

class PatientInfoPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            patient_id: "",
            disease: "",
            phase: "",
            p_status: "",
            // fk
            trial_id: "",
            p_username: "",
            p_password: "",
            // fk
            // researcher_id: "",
            researcher_id: "000000042"
            // researcher_id: localStorage.getItem('id')
        };
        // this.handleChange = this.handleChange.bind(this);
        // this.handleSubmit = this.handleSubmit.bind(this);
    }

    // handleChange = (e) => {
    //     this.setState({
    //         [e.target.name]: e.target.value
    //     })
    // }

    // handleSubmit = (e) => {
    //     alert('Submit ' + this.state);
    //     let discussion = {
    //         df_name: this.state.df_name,
    //         details: this.state.details,
    //         researcher_id: this.state.researcher_id
    //     }
    //     DiscussionService.createDiscussion(discussion)
    //         .then(data => {
    //             console.log(data)
    //         })
    //         .catch(err => {
    //             console.log(err)
    //         })
    // }

    render() {
        return (
            <div style={{margin: "0px auto 20px 10px"}}>
                {/* patient list */}
                <p style={{fontWeight: "bolder", fontSize: "20px"}}>Patient Profile</p>
                <p>Patient ID: {this.state.patient_id}</p>
                <p>Disease: {this.state.disease}</p>
                <p>Phase: {this.state.phase}</p>
                <p>Status: {this.state.p_status}</p>
                <p>Trial ID: {this.state.trial_id}</p>
                <p>Researcher ID: {this.state.researcher_id}</p>
                <Button color="yellow" style={{marginLeft: "10px"}}><Link to="/addDonor">Add Donor</Link></Button>
                <Button color="yellow" style={{marginLeft: "10px"}}><Link to="/editPatient">Edit Patient Profile</Link></Button>
                {/* create new discussion */}
                {/* update phase */}
                {/* update disease */}
                {/* update status */}
                {/* change trial */}
                {/* <form onSubmit={this.handleSubmit}>
                    <input type="text" name="df_name" value={this.state.df_name} onChange={this.handleChange} /><br />
                    <textarea name="details" value={this.state.details} onChange={this.handleChange} />
                    <input type="submit" value="Submit" />
                </form> */}

                {/* private String patient_id;
                private String disease;
                private String phase;
                private String p_status;
                // fk
                private String trial_id;
                private String p_username;
                private String p_password;
                // fk
                private String researcher_id; */}
            </div>
        )
    }

    componentDidMount() {
        console.log('asafdasfas');
        let config = {
            headers: {
                researcher_id: "000000052"
            }
        };
        // show discussion list
        PatientService.getPatientById(this.props.match.params.id, config)
            .then(data => {
                console.log(data)
                this.setState(data.data);
            })
            .catch(err => {
                console.log(err)
            })
    }
}

export default PatientInfoPage;