import React from 'react';
// import { Link } from 'react-router-dom';
import ResearcherService from '../service/ResearcherService';


const PrettyPrintJson = React.memo(({ data }) => (<div><pre>{JSON.stringify(data, null, 2)}</pre></div>));

class ResearcherInfoPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            researcher_id: "000000042"
            // researcher_id: localStorage.getItem('id')
        };
        // this.handleChange = this.handleChange.bind(this);
        // this.handleSubmit = this.handleSubmit.bind(this);
    }

    // handleChange = (e) => {
    //     this.setState({
    //         [e.target.name]: e.target.value
    //     })
    // }

    // handleSubmit = (e) => {
    //     alert('Submit ' + this.state);
    //     let discussion = {
    //         df_name: this.state.df_name,
    //         details: this.state.details,
    //         researcher_id: this.state.researcher_id
    //     }
    //     DiscussionService.createDiscussion(discussion)
    //         .then(data => {
    //             console.log(data)
    //         })
    //         .catch(err => {
    //             console.log(err)
    //         })
    // }

    render() {
        return (
            <div>
                <pre>{JSON.stringify(this.state, null, 2)}</pre>
            </div>
        )
    }

    componentDidMount() {
        console.log('this.props.match.params.id:' + this.props.match.params.id);
        let config = {
            headers: {
                researcher_id: "000000052"
            }
        };
        // show discussion list
        ResearcherService.getResearcherById(this.props.match.params.id, config)
            .then(data => {
                console.log(data);
                this.setState(data.data);
            })
            .catch(err => {
                console.log(err)
            })
    }
}

export default ResearcherInfoPage;