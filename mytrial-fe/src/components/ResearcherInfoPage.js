// SJSU CMPE 138 Fall 2021 TEAM1
import React from "react";
// import { Link } from 'react-router-dom';
import ResearcherService from "../service/ResearcherService";
import { withRouter } from "react-router";

class ResearcherInfoPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      r_name: "",
      researcher_id: localStorage.getItem("id"),
      role: localStorage.getItem("role"),
    };
  }

  render() {
    return (
      <div>
        <pre>{JSON.stringify(this.state, null, 2)}</pre>
      </div>
    );
  }

  componentDidMount() {
    let config = {
      headers: {
        researcher_id: "000000052",
      },
    };
    // show discussion list
    ResearcherService.getResearcherById(this.props.match.params.id, config)
      .then((data) => {
        this.setState({ ...data.data });
      })
      .catch((err) => {
        console.log(err);
      });
  }
}

export default withRouter(ResearcherInfoPage);
