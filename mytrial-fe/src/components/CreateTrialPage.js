import { Button, Form, Dropdown } from 'semantic-ui-react';
import { useState } from 'react';
import { ADD_TRIAL_END_POINT } from '../settings';
import { fetchMytrial } from '../utils';
import { withRouter } from 'react-router-dom';

const createTrial = (title, organization, phase, nctNum, status, targetEnroll, history) => {
    console.log(title, organization, phase, nctNum, status, targetEnroll);
    if (title && organization && phase && nctNum && status && targetEnroll) {
        // create a trial on the backend
        const data = {
            title,
            organization_name: organization,
            phase,
            nct_no: nctNum,
            trial_status: status,
            target_enrollment: targetEnroll
        };
        fetchMytrial(ADD_TRIAL_END_POINT, null, {method: 'POST'}, data, {'id': localStorage.getItem('id')})
        .then(res => {
            history.push('/trials');
        })
        .catch(err => {
            console.log(err)
        });
    } else {
        alert('Please fill in all required fields');
    }
}

const orgOptions = [
    {
        key: 'Jackson Labs',
        text: 'Jackson Labs',
        value: 'Jackson Labs'
    },
    {
        key: 'California State University, Channel Islands',
        text: 'California State University, Channel Islands',
        value: 'California State University, Channel Islands'
    },
    {
        key: 'SJSU Research Foundation',
        text: 'SJSU Research Foundation',
        value: 'SJSU Research Foundation'
    },
    {
        key: 'UCSF Benioff Children’s Hospital Oakland',
        text: 'UCSF Benioff Children’s Hospital Oakland',
        value: 'UCSF Benioff Children’s Hospital Oakland'
    }
];

const phaseOptions = [
    {
        key: 'Phase 1',
        text: 'Phase 1',
        value: 'Phase 1'
    },
    {
        key: 'Phase 1/2',
        text: 'Phase 1/2',
        value: 'Phase 1/2'
    },
    {
        key: 'Phase 2',
        text: 'Phase 2',
        value: 'Phase 2'
    },
    {
        key: 'Phase 3',
        text: 'Phase 3',
        value: 'Phase 3'
    }
];

const statusOptions = [
    {
        key: 'Lauching',
        text: 'Lauching',
        value: 'Lauching'
    },
    {
        key: 'Recruiting',
        text: 'Recruiting',
        value: 'Recruiting'
    },
    {
        key: 'Active, not recruiting',
        text: 'Active, not recruiting',
        value: 'Active, not recruiting'
    },
    {
        key: 'Completed',
        text: 'Completed',
        value: 'Completed'
    },
    {
        key: 'Suspended',
        text: 'Suspended',
        value: 'Suspended'
    },
    {
        key: 'Closed',
        text: 'Closed',
        value: 'Closed'
    }
];

const CreateTrialPage = ({history}) => {
    const [title, setTitle] = useState(null);
    const [organization, setOrganization] = useState(null);
    const [phase, setPhase] = useState(null);
    const [nctNum, setNctNum] = useState(null);
    const [status, setStatus] = useState(null);
    const [targetEnroll, setTargetEnroll] = useState(0);
    return (
        <div className="myform">
        <Form onSubmit={() => {createTrial(title, organization, phase, nctNum, status, targetEnroll, history)}}>
            <p style={{fontSize: "30px", textAlign: "center"}}>Create a New Trial</p>
            <Form.Field required>
                <label>Title</label>
                <input placeholder='title' onChange={e => {setTitle(e.target.value)}} />
            </Form.Field>
            <Form.Field required>
                <label>Organization</label>
                <Dropdown
                    placeholder='Select Phase'
                    fluid
                    selection
                    options={orgOptions}
                    value={organization}
                    onChange={(_, obj) => {setOrganization(obj.value)}}
                />
                {/* <input placeholder='organization' onChange={e => {setOrganization(e.target.value)}}/> */}
            </Form.Field>
            <Form.Field required>
                <label>Phase</label>
                <Dropdown
                    placeholder='Select Phase'
                    fluid
                    selection
                    options={phaseOptions}
                    value={phase}
                    onChange={(_, obj) => {setPhase(obj.value)}}
                />
            </Form.Field>
            <Form.Field required>
                <label>NCT_no</label>
                <input placeholder='NCT_no' onChange={e => {setNctNum(e.target.value)}} />
            </Form.Field>
            <Form.Field required>
                <label>Status</label>
                <Dropdown
                    placeholder='Select Status'
                    fluid
                    selection
                    options={statusOptions}
                    value={status}
                    onChange={(_, obj) => {setStatus(obj.value)}}
                />
            </Form.Field>
            <Form.Field required>
                <label>Target Enrollment</label>
                <input type="number" placeholder='0' onChange={e => {setTargetEnroll(e.target.value)}} />
            </Form.Field>
            <Button type='submit'>Submit</Button>
        </Form>
        </div>
    );
}

export default withRouter(CreateTrialPage);