import React from "react";
import { Link } from "react-router-dom";
// import PatientService from "../service/PatientService";
import axios from "axios";
import { PATIENT_INFO } from "../settings/";

class PatientInfoPage extends React.Component {
  constructor(props) {
    super(props);
    console.log(this.props);
    this.state = {
      patient_id: "",
      disease: "",
      phase: "",
      p_status: "",
      // fk
      trial_id: "",
      p_username: "",
      p_password: "",
      // fk
      // researcher_id: "",
      researcher_id: "",
      // researcher_id: localStorage.getItem('id')
    };
    // this.handleChange = this.handleChange.bind(this);
    // this.handleSubmit = this.handleSubmit.bind(this);
  }

  getData = () => {
    axios
      .get(PATIENT_INFO + this.props.match.params.id)
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
    let to_link = "/editpatient/" + this.props.match.params.id;
    return (
      <div>
        <center>
          <div className="card col-md-4 m-3">
            Patient ID: {this.state.patient_id} <br />
            Disease: {this.state.disease}
            <br />
            Phase: {this.state.phase}
            <br />
            Status: {this.state.p_status}
            <br />
            Trial ID: {this.state.trial_id}
            <br />
            Researcher ID: {this.state.researcher_id}
            <br />
          </div>
          <Link to={to_link}>
            <button className="btn btn-outline-primary">Edit</button>
          </Link>
        </center>
      </div>
    );
  }
}

export default PatientInfoPage;
