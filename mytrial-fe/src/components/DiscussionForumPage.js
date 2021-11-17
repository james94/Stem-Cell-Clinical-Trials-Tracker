// SJSU CMPE 138 Fall 2021 TEAM1
import React from "react";
import { Link } from "react-router-dom";
import DiscussionService from "../service/DiscussionService";
import { Button, Input, Form, List, Grid } from "semantic-ui-react";

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
    // param object
    let params = {
      df_id: "",
      df_name: "",
      details: "",
      researcher_id: "",
    };
    params.df_id = this.state.df_id;
    params.df_name = this.state.df_name;
    params.df_name = this.state.df_name;
    params.details = this.state.details;
    params.researcher_id = localStorage.getItem("id");
    if (params.df_id) {
      // update
      DiscussionService.updateDiscussion(params)
        .then((data) => {
          window.location.reload();
        })
        .catch((err) => {
          console.log(err);
        });
    } else {
      // create
      DiscussionService.createDiscussion(params)
        .then((data) => {
          window.location.reload();
        })
        .catch((err) => {
          console.log(err);
        });
    }
  };

  updateTopic = (e, id) => {
    alert("Update: " + id);
    DiscussionService.getDiscussionById(id)
      .then((data) => {
        this.setState({
          ...data.data,
        });
      })
      .catch((err) => {
        console.log(err);
      });
  };

  deleteTopic = (e, id) => {
    alert("Delete: " + id);
    DiscussionService.deleteDiscussion(id)
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
        {/* discussion list */}
        {this.state.discussions.length > 0 ? (
          <List>
            {this.state.discussions.map((e, i) => (
              <List.Item key={i}>
                <List.Content>
                  <Grid colums={3} celled>
                    <Grid.Row>
                      <Grid.Column width={10}>
                        <List.Header
                          as={Link}
                          content={e.df_name}
                          to={{ pathname: `/discussion/${e.df_id}` }}
                        />
                        <List.Description content={e.details} />
                      </Grid.Column>
                      <Grid.Column width={4}>
                        {e.researcher.r_name} <br />
                        {e.df_timestamp}
                      </Grid.Column>
                      <Grid.Column width={2}>
                        {e.researcher_id === localStorage.getItem("id") && (
                          <Button
                            onClick={(event) => {
                              this.updateTopic(event, e.df_id);
                            }}
                          >
                            Update
                          </Button>
                        )}
                        {e.researcher_id === localStorage.getItem("id") && (
                          <Button
                            onClick={(event) => {
                              this.deleteTopic(event, e.df_id);
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
        ) : (
          ""
        )}
        {/* create new discussion */}
        <Form onSubmit={this.handleSubmit}>
          <Form.Field required>
            <label>Topic</label>
            <Input
              required
              placeholder="your topic"
              name="df_name"
              value={this.state.df_name}
              onChange={this.handleChange}
            />
          </Form.Field>
          <Form.Field required>
            <label>content</label>
            <Form.TextArea
              required
              name="details"
              value={this.state.details}
              placeholder="your content"
              onChange={this.handleChange}
            ></Form.TextArea>
          </Form.Field>
          <Button type="submit">Submit</Button>
        </Form>
      </div>
    );
  }

  componentDidMount() {
    let config = {
      header: {
        researcher_id: localStorage.getItem("id"),
      },
    };
    // show discussion list
    DiscussionService.getDiscussions(config)
      .then((data) => {
        this.setState({
          discussions: data.data,
        });
      })
      .catch((err) => {
        console.log(err);
      });
  }
}

export default DiscussionForumPage;
