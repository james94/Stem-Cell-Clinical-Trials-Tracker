import React from 'react';
// import { Link } from 'react-router-dom';
import GrantsService from '../service/GrantsService';
import { withRouter } from "react-router";

class GrantInfoPage extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            researcher_id: localStorage.getItem('id'),
            role: localStorage.getItem('role'),
        }
    }

    render() {
        return (
            <div>
                <h2>Grant Info: {this.state.grant_number}</h2>
                <pre>
                    {JSON.stringify(this.state, null, 2)}
                </pre>
            </div>
        )
    }

    componentDidMount() {
        console.log(this.props.match.params.id)
        let config_params = {
            params: {
                grant_number: this.props.match.params.id
            }
        }

        GrantsService.getGrantsByGrantNumber(config_params)
            .then(response => {
                this.setState({
                    ...response.data
                });
            })
            .catch(err => {
                console.log(err)
            })
    }
}

export default withRouter(GrantInfoPage);

