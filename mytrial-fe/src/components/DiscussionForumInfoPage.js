// SJSU CMPE 138 Fall 2021 TEAM1
import React from "react";
// import { Link } from 'react-router-dom';
import DiscussionService from "../service/DiscussionService";
import ReplyService from "../service/ReplyService";
import { Grid, List, Button, Form } from "semantic-ui-react";
import { withRouter } from "react-router";

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
      researcher: {},
      researcher_id: localStorage.getItem("id"),
      role: localStorage.getItem("role"),
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange = (e) => {
    this.setState({
      [e.target.name]: e.target.value,
    });
  };

  handleSubmit = (e) => {
    e.preventDefault();
    let params = {
      reply_id: "",
      content: "",
      df_id: "",
      researcher_id: "",
    };
    params.reply_id = this.state.reply_id;
    params.content = this.state.content;
    params.df_id = this.state.df_id;
    params.researcher_id = localStorage.getItem("id");

    if (params.reply_id) {
      // update
      ReplyService.updateReply(params)
        .then((data) => {
          window.location.reload();
        })
        .catch((err) => {
          console.log(err);
        });
    } else {
      // create
      ReplyService.createReply(params)
        .then((data) => {
          window.location.reload();
        })
        .catch((err) => {
          console.log(err);
        });
    }
  };

  updateReply = (e, id) => {
    alert("Update: " + id);
    ReplyService.getReplyById(id)
      .then((data) => {
        this.setState({
          ...data.data,
        });
      })
      .catch((err) => {
        console.log(err);
      });
  };

  deleteReply = (e, id) => {
    alert("Delete: " + id);
    ReplyService.deleteReply(id)
      .then((data) => {
        window.location.reload();
      })
      .catch((err) => {
        console.log(err);
      });
  };

  render() {
    return (
      <div>
        <Grid celled>
          <Grid.Row>
            <Grid.Column width={2}>{this.state.df_id}</Grid.Column>
            <Grid.Column width={10}>{this.state.df_name}</Grid.Column>
            <Grid.Column width={4}>
              <Grid.Row>{this.state.researcher.r_name}</Grid.Row>
              <Grid.Row>{this.state.df_timestamp}</Grid.Row>
            </Grid.Column>
          </Grid.Row>
          <Grid.Row>
            <Grid.Column>
              <pre>{this.state.details}</pre>
            </Grid.Column>
          </Grid.Row>
        </Grid>
        <List>
          {this.state.replies.map((e, i) => (
            <List.Item key={i}>
              <List.Content>
                <Grid celled>
                  <Grid.Row>
                    <Grid.Column width={1}>{i + 1}</Grid.Column>
                    <Grid.Column width={10}>{e.content}</Grid.Column>
                    <Grid.Column width={3}>
                      {e.researcher.r_name}
                      <br />
                      {e.r_timestamp}
                    </Grid.Column>
                    <Grid.Column width={2}>
                      {e.researcher_id === localStorage.getItem("id") && (
                        <Button
                          onClick={(event) => {
                            this.updateReply(event, e.reply_id);
                          }}
                        >
                          Update
                        </Button>
                      )}
                      {e.researcher_id === localStorage.getItem("id") && (
                        <Button
                          onClick={(event) => {
                            this.deleteReply(event, e.reply_id);
                          }}
                        >
                          Delete
                        </Button>
                      )}
                    </Grid.Column>
                  </Grid.Row>
                </Grid>
              </List.Content>
            </List.Item>
          ))}
        </List>
        {/* create new reply */}
        <Form onSubmit={this.handleSubmit}>
          <Form.Field required>
            <label>Reply</label>
            <Form.TextArea
              required
              name="content"
              value={this.state.content}
              placeholder="your reply"
              onChange={this.handleChange}
            ></Form.TextArea>
          </Form.Field>
          <Button type="submit">Submit</Button>
        </Form>
      </div>
    );
  }

  componentDidMount() {
    // const id = this.props.match.params.id;
    // show reply list
    DiscussionService.getDiscussionById(this.props.match.params.id)
      .then((data) => {
        this.setState({ ...data.data });
      })
      .catch((err) => {
        console.log(err);
      });
  }
}

export default withRouter(DiscussionForumInfoPage);
