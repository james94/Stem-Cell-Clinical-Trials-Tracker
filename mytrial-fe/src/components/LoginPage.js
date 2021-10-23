import {useState} from 'react';
import { Button, Form } from 'semantic-ui-react';
import { LOGIN_END_POINT } from '../settings';
import { fetchMytrial } from '../utils';
import { withRouter } from 'react-router-dom';

const loginUser = (username, password, history) => {
    // authenticate and then save id in local storage
    fetchMytrial(LOGIN_END_POINT, null, {method: 'POST'}, {username, password})
        .then(data => {
            localStorage.setItem('id', data.id);
            history.push("/rhome");
        })
        .catch(err => {
            history.push("/");
            console.log(err);
        })
    console.log('Login with ' + username + password + localStorage.getItem('role'));
}

const FormExampleForm = (props) => {
    const [username, setUsername] = useState(null);
    const [password, setPassword] = useState(null);
    return (
        <Form onSubmit={() => {loginUser(username, password, props.history)}}>
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

const LoginPage = ({ history }) => {
    return (
        <div className="myform">
            <p>Login</p>
            <hr />
            <FormExampleForm history={history}/>
        </div>
    )
}

export default withRouter(LoginPage);