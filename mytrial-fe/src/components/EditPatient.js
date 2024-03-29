// SJSU CMPE 138 Fall 2021 TEAM1
import React, { Component } from "react";
import axios from "axios";
import { PATIIENT_API_BASE_URL, EDIT_PATIENT } from "../settings/";
import { Form } from "semantic-ui-react";
import { Link } from "react-router-dom";

class EditPatient extends Component {
  constructor(props) {
    super(props);
    this.state = {
      patient_id: "",
      disease: "",
      phase: "",
      p_status: "",
      trial_id: "",
      p_username: "",
      p_password: "",
      researcher_id: "",
    };
    this.setDisease = this.setDisease.bind(this);
    this.setPhase = this.setPhase.bind(this);
    this.setTrialId = this.setTrialId.bind(this);
    this.setStatus = this.setStatus.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  // get patient data using PATIENTS_ALL_BASE_URL ending in "/patient/{patient_id}"
  getData = () => {
    let config_header = {
      headers: {
        researcher_id: localStorage.getItem('id')
      }
    };

    axios
      .get(PATIIENT_API_BASE_URL + this.props.match.params.id, config_header)
      .then((response) => {
        this.setState({
          patient_id: response.data.patient_id,
          disease: response.data.disease,
          phase: response.data.phase,
          p_status: response.data.p_status,
          trial_id: response.data.trial_id,
          p_username: response.data.p_username,
          p_password: response.data.p_password,
          researcher_id: response.data.researcher_id,
        });
      })
      .catch((error) => {
        console.log(error);
      });
  };

  componentDidMount() {
    this.getData();
  }

  setDisease = (e) => {
    this.setState({ disease: e.target.value });
  };
  setPhase = (e) => {
    this.setState({ phase: e.target.value });
  };
  setStatus = (e) => {
    this.setState({ p_status: e.target.value });
  };
  setTrialId = (e) => {
    this.setState({ trial_id: e.target.value });
  };
  handleSubmit = () => {
    let updated_data = {
      disease: this.state.disease,
      phase: this.state.phase,
      p_status: this.state.p_status,
      trial_id: this.state.trial_id,
    };
    console.log("the updated data is: ");
    console.log(updated_data);

    axios
      .post(EDIT_PATIENT + this.props.match.params.id, updated_data)
      .then((data) => {
        console.log("the data after sending the post req is " + data);
        window.location.reload();
      })
      .catch((err) => {
        console.log("the error after sending the post req is " + err);
      });
  };

  render() {
    let href_link_submit = "/patient/" + this.props.match.params.id;

    return (
      <div className="col-md-8 mx-auto m-5">
        <Form onSubmit={this.handleSubmit}>
          <Form.Field>
            <label>Disease</label>
            <input
              placeholder="disease"
              value={this.state.disease}
              onChange={this.setDisease}
            />
          </Form.Field>
          <Form.Field>
            <label>Phase</label>
            <input
              placeholder="phase"
              value={this.state.phase}
              onChange={this.setPhase}
            />
          </Form.Field>
          <Form.Field>
            <label>Status</label>
            <input
              placeholder="status"
              value={this.state.p_status}
              onChange={this.setStatus}
            />
          </Form.Field>
          <Form.Field>
            <label>Trial ID</label>
            <input
              placeholder="trial id"
              value={this.state.trial_id}
              onChange={this.setTrialId}
            />
          </Form.Field>
          <center>
            <button
              className="btn btn-outline-primary m-3"
              type="submit"
            >
              Update data for Patient {this.state.patient_id}
            </button>
            <Link to={href_link_submit}>
              <button className="btn btn-outline-primary m-3">
                Go Back to the Info Page
              </button>
            </Link>
          </center>
        </Form>
      </div>
    );
  }
}

export default EditPatient;
