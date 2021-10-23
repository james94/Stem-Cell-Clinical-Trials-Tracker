import React from 'react';
import { fetchMytrial } from '../utils';
import { TRIALS_BY_RESEARCHER_END_POINT, TRIALS_BY_PATIENT_END_POINT} from '../settings';

class Trials extends React.Component {

    state = {
        trials: []
    };

    retrieveMyTrials = (url) => {
        fetchMytrial(url, null, {method: 'GET'}, null, {'id': '000000046'})
        .then(data => {
            console.log(data)
            this.setState({
               trials: data
            });
        })
        .catch(err => {
            console.log(err)
        })
    }

    componentDidMount() {
        localStorage.getItem('role') === 'researcher' ? 
                 this.retrieveMyTrials(TRIALS_BY_RESEARCHER_END_POINT) 
                 : this.retrieveMyTrials(TRIALS_BY_PATIENT_END_POINT);
    }

    render() {
        return (
            <div>
                <ul>
                    {this.state.trials.map((e,i) => <li key={i}>{e.title}</li>)}
                </ul>
            </div>
        )
    }
}

export default Trials;