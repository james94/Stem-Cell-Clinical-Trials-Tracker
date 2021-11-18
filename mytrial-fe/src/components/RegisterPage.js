// SJSU CMPE 138 Fall 2021 TEAM1
import {useState} from 'react';
import { Button, Form, Dropdown } from 'semantic-ui-react';
import { REGISTER_END_POINT } from '../settings';
import { fetchMytrial } from '../utils';
import { withRouter } from 'react-router-dom';

const registerUser = (r_name, organization, disease_area, r_username, r_password, history) => {
    // authenticate and then save id in local storage
    // organizations.map((organization) =>
    //     { console.log(organization); }
    // );

    // disease_areas.map((disease_area) =>
    //     { console.log(disease_area); }
    // );

    // console.log(organizations.length);
    // console.log(disease_areas.length);

    // console.log(name);
    // console.log(username);
    // console.log(password);
    // let researcher_data = {
    //     r_name: name,
    //     r_username: username,
    //     r_password: password,
    //     organization: organizations,
    //     disease_area: disease_areas
    // }

    // the problem is occurring here, when I call fetchMytrial, it catches error.
    fetchMytrial(REGISTER_END_POINT, null, {method: 'POST'}, { r_name, r_username, r_password, organization, disease_area })
        .then(data => {
            console.log(data);
            console.log('Registered with ' + r_name + r_username + r_password);
            history.push("/rhome");
        })
        .catch(err => {
            history.push("/");
            console.log(err);
        })
}

const diseaseAreaOptions = [
    { key: 'brain cancer', text: 'Brain Cancer', value: 'Brain Cancer' },
    { key: 'cancer', text: 'Cancer', value: 'Cancer' },
    { key: 'solid tumors', text: 'Solid Tumors', value: 'Solid Tumors' },
    { key: 'acute myeloid leukemia', text: 'Acute Myeloid Leukemia', value: 'Acute Myeloid Leukemia' }
]

const organizationOptions = [
    { key: 'aspen neuroscience', text: 'Aspen Neuroscience', value: 'Aspen Neuroscience' },
    { key: 'semma therapeutics', text: 'Semma Therapeutics', value: 'Semma Therapeutics' },
    { key: 'cal state univ, sacramento', text: 'Cal State Univ, Sacramento', value: 'Cal State Univ, Sacramento' },
    { key: 'lineage cell therapeutics inc.', text: 'Lineage Cell Therapeutics Inc.', value: 'Lineage Cell Therapeutics Inc.' }
]

const RegisterForm = (props) => {
    const [name, setName] = useState(null);
    const [organizations, setOrganizations] = useState([]);
    const [disease_areas, setDiseaseAreas] = useState([]);
    const [username, setUsername] = useState(null);
    const [password, setPassword] = useState(null);

    const handleOrgsChange = (e, data) => {
        // console.log('e.target.value: ' + e.target.value); // undefined
        console.log(data.value);
        setOrganizations(data.value);
    }

    const handleDiseasesChange = (e, data) => {
        // console.log('e.target.value: ' + e.target.value); // undefined
        console.log(data.value);
        setDiseaseAreas(data.value);
    }

    return (
        <Form onSubmit={() => {registerUser(name, organizations, disease_areas, username, password, props.history)}}>
            <Form.Field>
                <label>Name</label>
                <input placeholder='name' onChange={e => {setName(e.target.value)}} />
            </Form.Field>
            <Form.Field>
                <label>Organizations</label>
                <Dropdown placeholder='organizations' fluid multiple selection options = {organizationOptions}
                    onChange={handleOrgsChange}/>
            </Form.Field>
            <Form.Field>
                <label>Disease Areas</label>
                <Dropdown placeholder='disease areas' fluid multiple selection options = {diseaseAreaOptions}
                    onChange={handleDiseasesChange}/>
            </Form.Field>
            <Form.Field>
                <label>Username</label>
                <input placeholder='username' onChange={e => {setUsername(e.target.value)}} />
            </Form.Field>
            <Form.Field>
                <label>Password</label>
                <input placeholder='password' onChange={e => {setPassword(e.target.value)}}/>
            </Form.Field>
            <Button type='submit'>Submit</Button>
        </Form>)
}

const RegisterPage = ({ history }) => {
    return (
        <div className="myform">
            <p>Register</p>
            <hr />
            <RegisterForm history={history}/>
        </div>
    )
}

export default withRouter(RegisterPage);
