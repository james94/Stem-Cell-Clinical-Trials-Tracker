// SJSU CMPE 138 Fall 2021 TEAM1
import React from 'react';
import { Link } from 'react-router-dom';
import ResearcherService from '../service/ResearcherService';

class ResearcherPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            researchers: [],
        };
    }

    render() {
        return (
            <div>
                {/* researcher list */}
                <ul>
                    {this.state.researchers.map((e, i) => <li key={i}><Link to={{ pathname: `/researcher/${e.researcher_id}` }}>{e.r_name}</Link></li>)}
                </ul>
            </div>
        )
    }

    componentDidMount() {
        ResearcherService.getResearchers()
            .then(data => {
                this.setState({
                    researchers: data.data
                });
            })
            .catch(err => {
                console.log(err)
            })
    }
}

export default ResearcherPage;
