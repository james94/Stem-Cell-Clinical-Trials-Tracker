// SJSU CMPE 138 Fall 2021 TEAM1

import { useState } from 'react';
import { Button, Form, Dropdown } from 'semantic-ui-react';
import { EDIT_PATIENT_END_POINT } from '../settings';
// import { fetchMytrial } from '../utils';
import { useParams } from "react-router";
import { withRouter, Link } from 'react-router-dom';
import { fetchMytrial } from '../utils';

const editPatientProfile = (phase, disease, status, trial_id, patient_id, history) => {

    let patient_data = {
        phase: phase,
        disease: disease,
        status: status,
        trial_id: trial_id,
    }

    // useMemo only recompute the memoized value when a dep has changed
    let config = {
        headers: {
            researcher_id: localStorage.getItem('id')
        }
    };

    // patientId, I retrieve it through using react hooks useParams and pass it to this function.
    // PatientService.updatePatient(patient_data, config);

    fetchMytrial(EDIT_PATIENT_END_POINT, {patientId: patient_id}, {method: 'POST'}, patient_data, config)
        .then(data => {
            console.log('Updated Patient Profile with ' + phase + disease + status + trial_id);
            history.push(`"/patient/${patient_id}"`);
        })
        .catch(err => {
            history.push("/");
            console.log(err);
        })
}

const EditPatientProfileForm = (props) => { 
    const [disease, setDisease] = useState(null);
    const [phase, setPhase] = useState(null);
    const [status, setStatus] = useState(null);
    const [trial_id, setTrialId] = useState(null);
    const params = useParams(); // get id in "/editPatient/:id"

    return (
        <div className="myform">
            <p>Edit Patient Profile</p>
            <Form onSubmit={() => {editPatientProfile(phase, disease, status, trial_id, params.id, props.history)}}>
                <Form.Field>
                    <label>Disease</label>
                    <input placeholder={'disease'} onChange={e => {setDisease(e.target.value)}} />
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
                <Button type='submit'><Link to={{pathname: `"/patient/${params.id}"`}}>Submit</Link></Button>
            </Form>
        </div>
    )
}

const EditPatientPage = ({ history }) => {
    return (
        <div>
            {localStorage.getItem('role') === 'researcher' ? <EditPatientProfileForm history={history}/>: null}
        </div>
    )
}

export default withRouter(EditPatientPage);