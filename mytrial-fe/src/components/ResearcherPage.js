import React from 'react';
import { Link } from 'react-router-dom';
import ResearcherService from '../service/ResearcherService';

class ResearcherPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            researchers: [],
            // df_name: "",
            // details: "",
            // researcher_id: "000000042"
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
                {/* researcher list */}
                <ul>
                    {this.state.researchers.map((e, i) => <li key={i}><Link to={{ pathname: `/researcher/${e.researcher_id}` }}>{e.r_name}</Link></li>)}
                </ul>
                {/* create new discussion */}
                {/* <form onSubmit={this.handleSubmit}>
                    <input type="text" name="df_name" value={this.state.df_name} onChange={this.handleChange} /><br />
                    <textarea name="details" value={this.state.details} onChange={this.handleChange} />
                    <input type="submit" value="Submit" />
                </form> */}

                {/* researcher_id varchar(9) not null,
                r_name varchar(50) not null,
                r_username varchar(30) not null,
                r_password blob not null,
                primary key (researcher_id) */}
            </div>
        )
    }

    componentDidMount() {
        // let config = {
        //     headers: {
        //         researcher_id: "000000052"
        //     }
        // };
        // show discussion list

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