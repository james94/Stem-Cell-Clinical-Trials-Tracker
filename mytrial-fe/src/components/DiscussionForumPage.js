import React from 'react';
import { Link } from 'react-router-dom';
import DiscussionService from '../service/DiscussionService';

class DiscussionForumPage extends React.Component {

    constructor(props) {
        super(props);
        // init the value for form
        this.state = {
            discussions: [],
            details: "",
            df_id: "",
            df_name: "",
            df_timestamp: "",
            replies: [],
            researcher_id: "000000006",
            // researcher_id: localStorage.getItem('id'),
            // role: localStorage.getItem('role'),

        };
        console.log(localStorage);
        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange = (e) => {
        this.setState({
            [e.target.name]: e.target.value
        })
    }

    handleSubmit = (e) => {
        console.log('Submit ' + this.state);
        e.preventDefault();
        // param object
        let params = {
            df_id: "",
            df_name: "",
            details: "",
            df_timestamp: "",
            replies: [],
            researcher_id: "",
        }
        Object.assign(params, this.state);
        if (params.df_id) { // update
            console.log("params.df_id:" + params.df_id);
            DiscussionService.updateDiscussion(params)
                .then(data => {
                    console.log(data);
                    window.location.reload();
                })
                .catch(err => {
                    console.log(err)
                })
        } else { // create
            console.log("no params.df_id");
            DiscussionService.createDiscussion(params)
                .then(data => {
                    console.log(data)
                    window.location.reload();
                })
                .catch(err => {
                    console.log(err)
                })
        }

    }

    updateTopic = (e, id) => {
        alert('Update: ' + id);
        DiscussionService.getDiscussionById(id)
            .then(data => {
                console.log(data);
                this.setState({
                    ...data.data
                });
            })
            .catch(err => {
                console.log(err)
            })
    }

    deleteTopic = (e, id) => {
        alert('Delete: ' + id);
        DiscussionService.deleteDiscussion(id)
            .then(data => {
                console.log(data);
                window.location.reload();
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
                    {this.state.discussions.map((e, i) => <li key={i}><Link to={{ pathname: `/discussion/${e.df_id}` }}>{e.df_name}</Link><button onClick={(event) => { this.updateTopic(event, e.df_id) }}>Update</button><button onClick={(event) => { this.deleteTopic(event, e.df_id) }}>Delete</button></li>)}
                </ul>
                {/* create new discussion */}
                <form onSubmit={this.handleSubmit}>
                    <input type="text" name="df_name" value={this.state.df_name} onChange={this.handleChange} /><br />
                    <textarea name="details" value={this.state.details} onChange={this.handleChange} />
                    <input type="submit" value="Submit" />
                </form>
            </div>
        )
    }

    componentDidMount() {
        // show discussion list
        DiscussionService.getDiscussions()
            .then(data => {
                console.log(data.data)
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