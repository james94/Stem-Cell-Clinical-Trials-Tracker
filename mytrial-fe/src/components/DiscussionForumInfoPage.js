import React from 'react';
// import { Link } from 'react-router-dom';
import DiscussionService from '../service/DiscussionService';
import ReplyService from '../service/ReplyService';

class DiscussionForumInfoPage extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            details: "",
            df_id: 0,
            df_name: "",
            df_timestamp: "",
            replies: [],
            in_reply_content: "",
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
        // alert('Submit ' + this.state);
        let reply = {
            content: this.state.in_reply_content,
            df_id: this.state.df_id,
            researcher_id: this.state.researcher_id
        }
        ReplyService.createReply(reply)
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
                <div>
                    <ul>{this.state.df_id}</ul>
                    <ul>{this.state.df_name}</ul>
                    <ul>{this.state.details}</ul>
                    <ul>{this.state.df_timestamp}</ul>
                    {this.state.replies.map((e, i) => <li key={i}>{e.reply_id}{e.content}{e.r_timestamp}</li>)}
                </div>
                {/* create new reply */}
                <form onSubmit={this.handleSubmit}>
                    <textarea name="in_reply_content" value={this.state.in_reply_content} onChange={this.handleChange} />
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
                this.setState(data.data);
            })
            .catch(err => {
                console.log(err)
            })
    }
}

export default DiscussionForumInfoPage;