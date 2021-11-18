// SJSU CMPE 138 Fall 2021 TEAM1
import { useState, useEffect } from "react";
import { useParams } from "react-router";
import { Link } from 'react-router-dom';
import { TRIALS_BY_RESEARCHER_END_POINT, RESEARCHER_NAMES_BY_TRAIL } from "../settings";
import { fetchMytrial } from "../utils";
import { Button } from "semantic-ui-react";

export const TrialInfoPage = () => {
    const [trial, setTrial] = useState(null);
    const [researchers, setResearchers] = useState([]);
    const params = useParams();
    useEffect(() => {
        Promise.all([fetchMytrial(TRIALS_BY_RESEARCHER_END_POINT, { trialId: params.id }, { method: 'GET' }, null, { 'id': localStorage.getItem('id') }),
        fetchMytrial(RESEARCHER_NAMES_BY_TRAIL, { trialId: params.id }, { method: 'GET' }, null, { 'id': localStorage.getItem('id') })
        ])
            .then(data => {
                setTrial(data[0][0]);
                setResearchers(data[1]);
            })
    }, [params.id]);
    return (<div>
        {trial ? <TrialInfoComponent trial={trial} researchers={researchers} /> : null}
        {localStorage.getItem('role') === 'researcher' ?
            <Button as={Link} to={`/patient?trial_id=${params.id}`}>Patient List</Button> : null}
    </div>)
}

const TrialInfoComponent = (props) => {
    return (
        <div style={{ margin: "0px auto 20px 10px" }}>
            <p style={{ fontWeight: "bolder", fontSize: "20px" }}>{props.trial.title}</p>
            <p>Trial status: {props.trial["trial_status"]}</p>
            <p>Target Enrollment: {props.trial["target_enrollment"]}</p>
            <p>Phase: {props.trial["phase"]}</p>
            <p>Organization: {props.trial["organization_name"]}</p>
            <p>Researchers: {props.researchers.map(e => <span key={e} style={{ marginLeft: "5px" }}>{e}</span>)}</p>
        </div>)
}

export default TrialInfoPage;
