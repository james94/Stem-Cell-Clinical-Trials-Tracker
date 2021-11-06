import { Button, Form, Dropdown } from 'semantic-ui-react';
import { useState } from 'react';

const createTrial = (title, organization, phase, nctNum, status, targetEnroll) => {
    console.log(title, organization, phase, nctNum, status, targetEnroll);
    if (title && organization && phase && nctNum && status && targetEnroll) {
        // create a trial on the backend
    } else {
        alert('Please fill in all required fields');
    }
}

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

const CreateTrialPage = () => {
    const [title, setTitle] = useState(null);
    const [organization, setOrganization] = useState(null);
    const [phase, setPhase] = useState(null);
    const [nctNum, setNctNum] = useState(null);
    const [status, setStatus] = useState(null);
    const [targetEnroll, setTargetEnroll] = useState(0);
    return (
        <div className="myform">
        <Form onSubmit={() => {createTrial(title, organization, phase, nctNum, status, targetEnroll)}}>
            <p style={{fontSize: "30px", textAlign: "center"}}>Create a New Trial</p>
            <Form.Field required>
                <label>Title</label>
                <input placeholder='title' onChange={e => {setTitle(e.target.value)}} />
            </Form.Field>
            <Form.Field required>
                <label>Organization</label>
                <input placeholder='organization' onChange={e => {setOrganization(e.target.value)}}/>
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

export default CreateTrialPage;