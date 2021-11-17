import { Button, Form} from 'semantic-ui-react';
import { useState } from 'react';
import DonorService from "../service/DonorService";
import {useParams, withRouter} from "react-router-dom";

const updateDonor = (patient_id, name, email) => {
    console.log(patient_id, name, email);
    if (name && email) {
        let config = {
            headers: {
                researcher_id: localStorage.getItem("id")
            }
        }
        let donor = {
            name:name,
            email:email
        }
        DonorService.UpdateDonor(patient_id, donor, config)
                 .then(data => {
                     console.log(data)
                 })
                 .catch(err => {
                     console.log(err)
                 })
    } else {
        alert('Please fill in all required fields');
    }
}

const UpdateDonorPage = ({location}) => {
    const [name, setName] = useState(null);
    const [email, setEmail] = useState(null);
    const patient_id = useParams().id;
    console.log(patient_id)
    return (
        <div className="myform">
            <Form onSubmit={() => {updateDonor(patient_id, name, email)}}>
                <p style={{fontSize: "30px", textAlign: "center"}}>Update Donor</p>
                <Form.Field required>
                    <label>Name</label>
                    <input placeholder='name' onChange={e => {setName(e.target.value)}} />
                </Form.Field>
                <Form.Field required>
                    <label>Email</label>
                    <input placeholder='email' onChange={e => {setEmail(e.target.value)}}/>
                </Form.Field>
                <Button type='submit'>Submit</Button>
            </Form>
        </div>
    )
}
export default withRouter(UpdateDonorPage);