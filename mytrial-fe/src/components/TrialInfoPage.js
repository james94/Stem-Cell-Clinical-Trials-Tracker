import { useState, useEffect } from "react";
import { useParams } from "react-router";
import { TRIALS_BY_RESEARCHER_END_POINT } from "../settings";
import { fetchMytrial } from "../utils";
import {Button} from "semantic-ui-react";

export const TrialInfoPage = () => {
    const [trial, setTrial] = useState(null);
    const params = useParams();
    useEffect(() => {
        fetchMytrial(TRIALS_BY_RESEARCHER_END_POINT, {trialId: params.id}, {method: 'GET'}, null, {'id': '000000046'})
        .then(data => {
            setTrial(data[0]);
        })
    }, [params.id]);
    return (<div>
        {trial ? <TrialInfoComponent trial={trial}/> : null}
        {localStorage.getItem('role') === 'researcher' ? <Button color="yellow" style={{marginLeft: "10px"}}>Patient List</Button> : null}
    </div>)
}

const TrialInfoComponent = (props) => {
    return (
    <div style={{margin: "0px auto 20px 10px"}}>
        <p style={{fontWeight: "bolder", fontSize: "20px"}}>{props.trial.title}</p>
        <p>Trial status: {props.trial["trial_status"]}</p>
        <p>Target Enrollment: {props.trial["target_enrollment"]}</p>
        <p>Phase: {props.trial["phase"]}</p>
        <p>Organization: {props.trial["organization_name"]}</p>
    </div>)
}

export default TrialInfoPage;