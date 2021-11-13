import React from "react";
import { Link } from "react-router-dom";
import PatientService from "../service/PatientService";

class PatientPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      patients: [],
      // df_name: "",
      // details: "",
      researcher_id: "000000042",
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
        {/* patient list */}
        <div className="d-flex justify-content-center">
          <ul>
            "disease, phase, status, trial_id"
            {this.state.patients.map((e, i) => (
              <li key={i}>
                <Link to={{ pathname: `/patient/${e.patient_id}` }}>
                  {e.disease}, {e.phase}, {e.p_status}, {e.trial_id}
                </Link>
              </li>
            ))}
          </ul>
        </div>
        {/* create new discussion */}
        {/* <form onSubmit={this.handleSubmit}>
                    <input type="text" name="df_name" value={this.state.df_name} onChange={this.handleChange} /><br />
                    <textarea name="details" value={this.state.details} onChange={this.handleChange} />
                    <input type="submit" value="Submit" />
                </form> */}

        {/* private String patient_id;
                private String disease;
                private String phase;
                private String p_status;
                // fk
                private String trial_id;
                private String p_username;
                private String p_password;
                // fk
                private String researcher_id; */}
        <div className="d-flex justify-content-center"><Link to="/searchpatients" ><button className="btn btn-outline-info">View all patients</button></Link></div>
      </div>
    );
  }

  componentDidMount() {
    console.log("asafdasfas");
    let config = {
      headers: {
        researcher_id: "000000052",
      },
    };
    // show discussion list
    PatientService.getPatients(config)
      .then((data) => {
        this.setState({
          patients: data.data,
        });
      })
      .catch((err) => {
        console.log(err);
      });
  }
}

export default PatientPage;
