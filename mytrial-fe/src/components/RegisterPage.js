import {useState} from 'react';
import { Button, Form, Dropdown } from 'semantic-ui-react';
import { REGISTER_END_POINT } from '../settings';
import { fetchMytrial } from '../utils';
import { withRouter } from 'react-router-dom';
import ResearcherService from '../service/ResearcherService';

const registerUser = (name, organizations, disease_areas, username, password, history) => {
    // authenticate and then save id in local storage
    let researcher_data = {
        r_name: name,
        r_username: username,
        r_password: password,
        organization: organizations,
        disease_area: disease_areas
    }

    fetchMytrial(REGISTER_END_POINT, null, {method: 'POST'}, researcher_data)
        .then(data => {
            console.log('Registered with ' + name + username + password + "organization: " + organizations);
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

// const DropdownDiseaseAreaMultiSelection = () => {
//     return (
//         <Dropdown placeholder='disease areas' fluid multiple selection options = {diseaseAreaOptions} />
//     )
// }

// const OrganizationMultiSelection = () => {
//     return (
//         <Dropdown placeholder='organizations' fluid multiple selection options = {organizationOptions} />
//     )
// }

const RegisterForm = (props) => {
    const [name, setName] = useState(null);
    const [organizations, setOrganizations] = useState([]);
    const [disease_areas, setDiseaseAreas] = useState([]);
    const [username, setUsername] = useState(null);
    const [password, setPassword] = useState(null);

    // const handleOrgsChange = (e) => {
    //     var orgOptions = e.target.options;
    //     var orgs = [];
    //     for(var i = 0, l = orgOptions.length; i < l; i++) {
    //         orgs.concat(orgOptions[i].value);
    //     }
    //     setOrganizations(orgs);
    // }

    // const handleDiseasesChange = (e) => {
    //     var disAreasOptions = e.target.options;
    //     var disAreas = [];
    //     for(var i = 0, l = disAreasOptions.length; i < l; i++) {
    //         disAreasOptions.concat(disAreasOptions[i].value);
    //     }
    //     setDiseaseAreas(disAreas);
    // }

    return (
        <Form onSubmit={() => {registerUser(name, organizations, disease_areas, username, password, props.history)}}>
            <Form.Field>
                <label>Name</label>
                <input placeholder='name' onChange={e => {setName(e.target.value)}} />
            </Form.Field>
            <Form.Field>
                <label>Organizations</label>
                {/* <OrganizationMultiSelection /> */}
                {/* <Dropdown placeholder='organizations' fluid multiple selection options = {organizationOptions} 
                    onChange={handleOrgsChange}/> */}

                <Dropdown placeholder='organizations' fluid multiple selection options = {organizationOptions} 
                    onChange={e => {setOrganizations(e.target.options)}}/>
                {/* <input placeholder='organizations' onChange={this.handleChange} /> */}
            </Form.Field>
            <Form.Field>
                <label>Disease Areas</label>
                {/* <DropdownDiseaseAreaMultiSelection /> */}
                {/* <Dropdown placeholder='disease areas' fluid multiple selection options = {diseaseAreaOptions} 
                    onChange={handleDiseasesChange}/> */}

                <Dropdown placeholder='disease areas' fluid multiple selection options = {diseaseAreaOptions} 
                    onChange={e => {setDiseaseAreas(e.target.options)}}/>
                {/* <input placeholder='disease areas' onChange={this.handleChange} /> */}
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

export default RegisterPage;