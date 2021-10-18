import {useState} from 'react';
import { Button, Form } from 'semantic-ui-react';

const loginUser = (username, password) => {
    console.log(username, password, localStorage.getItem('role'));
}

const FormExampleForm = () => {
    const [username, setUsername] = useState(null);
    const [password, setPassword] = useState(null);
    return (
        <Form onSubmit={() => {loginUser(username, password)}}>
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

const LoginPage = () => {
    return (
        <div className="myform">
            <p>Login</p>
            <hr />
            <FormExampleForm />
        </div>
    )
}

export default LoginPage;