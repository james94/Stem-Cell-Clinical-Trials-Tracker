import React from 'react';
import { Link } from 'react-router-dom';
import DiscussionService from '../service/DiscussionService';

class DiscussionForumPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            discussions: [],
            df_name: "",
            details: "",
            researcher_id: "000000042"
            // researcher_id: localStorage.getItem('id')
        };
        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange = (e) => {
        this.setState({
            [e.target.name]: e.target.value
        })
    }

    handleSubmit = (e) => {
        alert('Submit ' + this.state);
        let discussion = {
            df_name: this.state.df_name,
            details: this.state.details,
            researcher_id: this.state.researcher_id
        }
        DiscussionService.createDiscussion(discussion)
            .then(data => {
                console.log(data)
            })
            .catch(err => {
                console.log(err)
            })
    }

    render() {
        return (
            <div>
                {/* discussion list */}
                <ul>
                    {this.state.discussions.map((e, i) => <li key={i}><Link to={{ pathname: `/discussions/${e.df_id}` }}>{e.df_name}</Link></li>)}
                </ul>
                {/* create new discussion */}
                <form onSubmit={this.handleSubmit}>
                    <input type="text" name="df_name" value={this.state.df_name} onChange={this.handleChange} /><br />
                    <textarea name="details" value={this.state.details} onChange={this.handleChange} />
                    <input type="submit" value="Submit" />
                </form>

                {/* private String df_id;
                private String df_name;
                private java.sql.Timestamp df_timestamp;
                private String details;
                private String researcher_id; */}
            </div>
        )
    }

    componentDidMount() {
        // show discussion list
        DiscussionService.getDiscussions()
            .then(data => {
                this.setState({
                    discussions: data.data
                });
            })
            .catch(err => {
                console.log(err)
            })
    }
}

export default DiscussionForumPage;