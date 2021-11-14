// SJSU CMPE 138 Fall 2021 TEAM1

import {useState} from 'react';
import { Button, Form, Dropdown } from 'semantic-ui-react';
// import { EDIT_PATIENT_END_POINT } from '../settings';
// import { fetchMytrial } from '../utils';
import { withRouter } from 'react-router-dom';
import PatientService from '../service/PatientService';

// const getPatientData = () => {
//     PatientService.getPatientById()
// }

const editPatientProfile = (phase, disease, status, trial_id, history) => {

    let patient_data = {
        phase: phase,
        disease: disease,
        status: status,
        trial_id: trial_id,
    }

    let config = {
        headers: {
            researcher_id: localStorage.getItem('id')
        }
    };

    // patientId need it.
    PatientService.updatePatient(patient_data, config);

    // fetchMytrial(EDIT_PATIENT_END_POINT, null, {method: 'POST'}, patient_data)
    //     .then(data => {
    //         console.log(data);
    //         console.log('Edited Patient Profile for ' + phase + disease + status + trial_id + researcher_id);
    //         history.push("/patient/:id"); 
    //     })
    //     .catch(err => {
    //         history.push("/");
    //         console.log(err);
    //     })
}

const EditPatientProfileForm = (props) => {
    const [disease, setDisease] = useState(null);
    const [phase, setPhase] = useState(null);
    const [status, setStatus] = useState(null);
    const [trial_id, setTrialId] = useState(null);

    return (
        <Form onSubmit={() => {editPatientProfile(phase, disease, status, trial_id, props.history)}}>
            <Form.Field>
                <label>Disease</label>
                <input placeholder='disease' onChange={e => {setDisease(e.target.value)}} />
            </Form.Field>
            <Form.Field>
                <label>Phase</label>
                <input placeholder='phase' onChange={e => {setPhase(e.target.value)}} />
            </Form.Field>
            <Form.Field>
                <label>Status</label>
                <input placeholder='status' onChange={e => {setStatus(e.target.value)}} />
            </Form.Field>
            <Form.Field>
                <label>Trial ID</label>
                <input placeholder='trial id' onChange={e => {setTrialId(e.target.value)}} />
            </Form.Field>
            <Button type='submit'>Submit</Button>
        </Form>
    )
}

const EditPatientPage = ({ history }) => {
    return (
        <div className="myform">
            <p>Edit Patient Profile</p>
            <hr />
            <EditPatientProfileForm history={history}/>
        </div>
    )
}

export default withRouter(EditPatientPage);