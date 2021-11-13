import React from 'react';
// import { Link } from 'react-router-dom';
import DiscussionService from '../service/DiscussionService';
import ReplyService from '../service/ReplyService';

class DiscussionForumInfoPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            // discussion topic
            details: "",
            df_id: "",
            df_name: "",
            df_timestamp: "",
            replies: [],
            // reply form
            reply_id: "",
            r_timestamp: "",
            content: "",
            researcher_id: '"000000006"',
            // researcher_id: localStorage.getItem('id'),
            // role: localStorage.getItem('role')
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
        e.preventDefault();
        let params = {
            reply_id: "",
            r_timestamp: "",
            content: "",
            df_id: "",
            researcher_id: ""
        }
        Object.assign(params, this.state);
        if (params.reply_id) { // update
            ReplyService.updateReply(params)
            .then(data => {
                console.log(data);
                window.location.reload();
            })
            .catch(err => {
                console.log(err)
            })
        } else { // create
            ReplyService.createReply(params)
                .then(data => {
                    console.log(data);
                    window.location.reload();
                })
                .catch(err => {
                    console.log(err)
                })
        }
    }

    updateReply = (e, id) => {
        alert('Update: ' + id);
        ReplyService.getReplyById(id)
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

    deleteReply = (e, id) => {
        alert('Delete: ' + id);
        ReplyService.deleteReply(id)
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
                <div>
                    <ul>{this.state.df_id}</ul>
                    <ul>{this.state.df_name}</ul>
                    <ul>{this.state.details}</ul>
                    <ul>{this.state.df_timestamp}</ul><br/>
                    {this.state.replies.map((e, i) => <li key={i}>{e.reply_id}{e.content}{e.r_timestamp} <button onClick={(event) => { this.updateReply(event, e.reply_id) }}>Update</button><button onClick={(event) => { this.deleteReply(event, e.reply_id) }}>Delete</button></li>)}
                </div>
                {/* create new reply */}
                <form onSubmit={this.handleSubmit}>
                    <textarea name="content" value={this.state.content} onChange={this.handleChange} />
                    <input type="submit" value="Submit" />
                </form>
            </div>
        )
    }

    componentDidMount() {
        // const id = this.props.match.params.id;
        // show reply list
        DiscussionService.getDiscussionById(this.props.match.params.id)
            .then(data => {
                console.log(data);
                this.setState({ ...data.data });
            })
            .catch(err => {
                console.log(err)
            })
    }
}

export default DiscussionForumInfoPage;