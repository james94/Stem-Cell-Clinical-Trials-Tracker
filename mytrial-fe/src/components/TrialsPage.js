import React from 'react';
import { Link, withRouter} from 'react-router-dom';
import { fetchMytrial } from '../utils';
import { TRIALS_BY_RESEARCHER_END_POINT } from '../settings';

class Trials extends React.Component {

    state = {
        trials: []
    };

    retrieveMyTrialsByUserId = (url) => {
        fetchMytrial(url, null, {method: 'GET'}, null, {'id': localStorage.getItem('id')})
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

    retrieveMyTrialsByDisease = (url, disease) => {
        fetchMytrial(url, {'disease': disease}, {method: 'GET'}, null, {'id': localStorage.getItem('id')})
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
        //const { disease } = this.props.location ? this.props.location.state : null;
        localStorage.getItem('role') === 'researcher' ? 
                 this.retrieveMyTrialsByUserId(TRIALS_BY_RESEARCHER_END_POINT) 
                 : this.retrieveMyTrialsByDisease(TRIALS_BY_RESEARCHER_END_POINT, this.props.location.state);
    }

    render() {
        return (
            <div>
                <ul>
                    {this.state.trials.map((e,i) => <li key={i}><Link to={{pathname: `/trials/${e.trial_id}`}}>{e.title}</Link></li>)}
                </ul>
            </div>
        )
    }
}

export default withRouter(Trials);